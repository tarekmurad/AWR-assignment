import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:aw_rostamani/src/core/utils/helpers.dart';
import 'package:aw_rostamani/src/features/assignments/presentation/widgets/customer_info_widget.dart';
import 'package:aw_rostamani/src/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/global_vars.dart';
import '../../../../core/shared_components/widgets/button_widget.dart';
import '../../../../core/shared_components/widgets/divider.dart';
import '../../../../core/shared_components/widgets/loader_widget.dart';
import '../../../../core/shared_components/widgets/location_details_widget.dart';
import '../../../../core/shared_components/widgets/status_widget.dart';
import '../../../../core/shared_components/widgets/vehicle_information_widget.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/assets.dart';
import '../../../../core/utils/permissions.dart';
import '../bloc/bloc.dart';

@RoutePage()
class AssignmentDetailsPage extends StatefulWidget {
  final int id;
  final String refNumber;

  const AssignmentDetailsPage(
      {super.key, required this.id, required this.refNumber});

  @override
  _AssignmentDetailsPageState createState() => _AssignmentDetailsPageState();
}

class _AssignmentDetailsPageState extends State<AssignmentDetailsPage> {
  final _bloc = getIt<AssignmentBloc>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  GoogleMapController? mapController;
  Marker? currentLocationMarker;
  Marker? sourceMarker;
  Marker? destinationMarker;
  Polyline? routePolyline;
  int currentIndex = 0;
  Timer? timer;
  String _mapStyle = '';

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    _initializeMarkers();

    _bloc.add(GetAssignmentDetailsEvent(id: widget.id));

    DefaultAssetBundle.of(context)
        .loadString('assets/styles/map_style.json')
        .then((style) {
      _mapStyle = style;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          '#${widget.refNumber}',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          color: AppColors.blackColor,
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 18.w,
          onPressed: () {
            context.router.maybePop();
          },
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            BlocListener<AssignmentBloc, AssignmentState>(
              bloc: _bloc,
              listener: (context, state) {
                if (state is GetAssignmentDetailsSucceed) {
                  if (state.assignment.status ==
                      AssignmentStatus.in_transit.name) {
                    startLocationSimulation();
                  } else if (state.assignment.status ==
                      TrackingStatus.delivered.name) {
                    routePolyline = Polyline(
                      polylineId: const PolylineId('route'),
                      points: routePoints,
                      color: Colors.blue,
                      width: 5,
                    );
                  }
                }
              },
              child: BlocBuilder<AssignmentBloc, AssignmentState>(
                bloc: _bloc,
                buildWhen: (previous, current) {
                  if (current is GetAssignmentDetailsLoading ||
                      current is GetAssignmentDetailsSucceed ||
                      current is GetAssignmentDetailsFailed) {
                    return true;
                  } else {
                    return false;
                  }
                },
                builder: (context, state) {
                  if (state is GetAssignmentDetailsLoading) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: LoaderWidget(
                              size: 30.w,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is GetAssignmentDetailsSucceed) {
                    return Expanded(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 300,
                                  child: GoogleMap(
                                    style: _mapStyle,
                                    onMapCreated: _onMapCreated,
                                    zoomControlsEnabled: false,
                                    scrollGesturesEnabled: true,
                                    zoomGesturesEnabled: true,
                                    myLocationEnabled: false,
                                    myLocationButtonEnabled: false,
                                    markers: {
                                      if (currentLocationMarker != null)
                                        currentLocationMarker!,
                                      if (sourceMarker != null) sourceMarker!,
                                      if (destinationMarker != null)
                                        destinationMarker!,
                                    },
                                    polylines: routePolyline != null
                                        ? {routePolyline!}
                                        : <Polyline>{},
                                    initialCameraPosition: CameraPosition(
                                      target: routePoints[0],
                                      zoom: 11,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 20.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          StatusWidget(
                                            type: state.assignment.type,
                                            color: AppColors.blackColor,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          StatusWidget(
                                            type: state.assignment.status,
                                            color: Helper.getStatusColor(
                                                state.assignment.status ?? ''),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(
                                        'Trip Tracking Details',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      CustomerInfoWidget(
                                        customerName:
                                            state.assignment.customer?.name ??
                                                '',
                                        onCallPressed: () {
                                          _makePhoneCall(state
                                                  .assignment.customer?.phone ??
                                              '');
                                        },
                                      ),
                                      const DividerWidget(),
                                      VehicleInformationWidget(
                                        plateNumber: state
                                                .assignment.car?.licensePlate ??
                                            '',
                                        vehicleMake:
                                            state.assignment.car?.make ?? '',
                                        vehicleModel:
                                            state.assignment.car?.model ?? '',
                                        vehicleColor:
                                            state.assignment.car?.color ?? '',
                                      ),
                                      const DividerWidget(),
                                      LocationDetailsWidget(
                                        sourceAddress: state.assignment
                                                .sourceLocation?.addressNotes ??
                                            '',
                                        destinationAddress: state
                                                .assignment
                                                .destinationLocation
                                                ?.addressNotes ??
                                            '',
                                      ),
                                      const SizedBox(
                                        height: 80,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.w, right: 20.w, top: 10.h),
                                  child: BlocListener<AssignmentBloc,
                                      AssignmentState>(
                                    bloc: _bloc,
                                    listener: (context, buttonState) {
                                      if (buttonState is StartTripSucceed) {
                                        startLocationSimulation();
                                        state.assignment.status =
                                            AssignmentStatus.in_transit.name;
                                      } else if (buttonState
                                          is EndTripSucceed) {
                                        endLocationSimulation();
                                        state.assignment.status =
                                            AssignmentStatus.delivered.name;
                                      }
                                    },
                                    child: BlocBuilder<AssignmentBloc,
                                            AssignmentState>(
                                        bloc: _bloc,
                                        builder: (context, buttonState) {
                                          if (state.assignment.status ==
                                              AssignmentStatus
                                                  .awaiting_pickup.name) {
                                            return ButtonWidget(
                                              onPressed: () {
                                                _bloc.add(StartTripEvent(
                                                    id: state.assignment.id!));
                                              },
                                              labelText: "Start Trip",
                                              color: AppColors.primaryColor,
                                              loading: buttonState
                                                  is StartTripLoading,
                                            );
                                          } else if (state.assignment.status ==
                                              AssignmentStatus
                                                  .in_transit.name) {
                                            return ButtonWidget(
                                              onPressed: () {
                                                _bloc.add(EndTripEvent(
                                                    id: state.assignment.id!));
                                              },
                                              labelText: "End Trip",
                                              color: AppColors.primaryColor,
                                              loading:
                                                  buttonState is EndTripLoading,
                                            );
                                          } else {
                                            return const SizedBox();
                                          }
                                        }),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _initializeMarkers() async {
    BitmapDescriptor sourceIcon =
        await Helper.getMarkerFromAsset(Assets.sourceIcon, 30, 60);
    sourceMarker = Marker(
      markerId: const MarkerId('source'),
      position: routePoints.first,
      icon: sourceIcon,
      infoWindow: const InfoWindow(title: 'Source'),
    );

    BitmapDescriptor destinationIcon =
        await Helper.getMarkerFromAsset(Assets.destinationIcon, 30, 60);
    destinationMarker = Marker(
      markerId: const MarkerId('destination'),
      position: routePoints.last,
      icon: destinationIcon,
      infoWindow: const InfoWindow(title: 'Destination'),
    );
  }

  // TODO: This should be fetched from Firebase Realtime Messaging, but for now, we will use a simulation.
  void startLocationSimulation() async {
    BitmapDescriptor markerIcon =
        await Helper.getMarkerFromAsset(Assets.markerIcon, 30, 30);

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentIndex < routePoints.length) {
        setState(() {
          currentLocationMarker = Marker(
            markerId: const MarkerId("vehicle"),
            position: routePoints[currentIndex],
            icon: markerIcon,
            infoWindow: const InfoWindow(title: 'Marker'),
            anchor: const Offset(0.5, 0.5),
          );

          routePolyline = Polyline(
            polylineId: const PolylineId('route'),
            points: routePoints.sublist(0, currentIndex + 1),
            color: Colors.blue,
            width: 5,
          );
        });

        mapController?.animateCamera(
          CameraUpdate.newLatLng(routePoints[currentIndex]),
        );
        currentIndex++;
      } else {
        timer.cancel();
      }
    });
  }

  void endLocationSimulation() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    currentLocationMarker = null;
    currentIndex = 0;
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
