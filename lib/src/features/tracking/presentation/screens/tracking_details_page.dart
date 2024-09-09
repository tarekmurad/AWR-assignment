import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:aw_rostamani/src/core/shared_components/widgets/vehicle_information_widget.dart';
import 'package:aw_rostamani/src/features/tracking/presentation/widgets/customer_information_widget.dart';
import 'package:aw_rostamani/src/features/tracking/presentation/widgets/vendor_info_widget.dart';
import 'package:aw_rostamani/src/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/global_vars.dart';
import '../../../../core/shared_components/widgets/divider.dart';
import '../../../../core/shared_components/widgets/loader_widget.dart';
import '../../../../core/shared_components/widgets/location_details_widget.dart';
import '../../../../core/shared_components/widgets/status_widget.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/assets.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/utils/permissions.dart';
import '../../../assignments/presentation/widgets/status_card.dart';
import '../bloc/bloc.dart';

@RoutePage()
class TrackingDetailsPage extends StatefulWidget {
  final int id;
  final String refNumber;

  const TrackingDetailsPage(
      {super.key, required this.id, required this.refNumber});

  @override
  _TrackingDetailsPageState createState() => _TrackingDetailsPageState();
}

class _TrackingDetailsPageState extends State<TrackingDetailsPage> {
  final _bloc = getIt<TrackingBloc>();
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

    _bloc.add(GetTrackingDetailsEvent(id: widget.id));

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
            BlocListener<TrackingBloc, TrackingState>(
              bloc: _bloc,
              listener: (context, state) {
                if (state is GetTrackingDetailsSucceed) {
                  if (state.tracking.status == TrackingStatus.in_transit.name) {
                    startLocationSimulation();
                  } else if (state.tracking.status ==
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
              child: BlocBuilder<TrackingBloc, TrackingState>(
                bloc: _bloc,
                buildWhen: (previous, current) {
                  if (current is GetTrackingDetailsLoading ||
                      current is GetTrackingDetailsSucceed ||
                      current is GetTrackingDetailsFailed) {
                    return true;
                  } else {
                    return false;
                  }
                },
                builder: (context, state) {
                  if (state is GetTrackingDetailsLoading) {
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
                  } else if (state is GetTrackingDetailsSucceed) {
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
                                            type: state.tracking.type,
                                            color: AppColors.blackColor,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          StatusWidget(
                                            type: state.tracking.status,
                                            color: Helper.getStatusColor(
                                                state.tracking.status ?? ''),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      StatusCard(
                                        title: getStatusTitle(
                                            state.tracking.status ?? ''),
                                        desc: getStatusDesc(
                                            state.tracking.status ?? ''),
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
                                      VendorInfoWidget(
                                        vendorName:
                                            state.tracking.vendor?.name ?? '',
                                        onCallPressed: () {
                                          _makePhoneCall(
                                              state.tracking.vendor?.phone ??
                                                  '');
                                        },
                                      ),
                                      const DividerWidget(),
                                      LocationDetailsWidget(
                                        sourceAddress: state.tracking
                                                .sourceLocation?.addressNotes ??
                                            '',
                                        destinationAddress: state
                                                .tracking
                                                .destinationLocation
                                                ?.addressNotes ??
                                            '',
                                      ),
                                      const DividerWidget(),
                                      VehicleInformationWidget(
                                        plateNumber:
                                            state.tracking.car?.licensePlate ??
                                                '',
                                        vehicleMake:
                                            state.tracking.car?.make ?? '',
                                        vehicleModel:
                                            state.tracking.car?.model ?? '',
                                        vehicleColor:
                                            state.tracking.car?.color ?? '',
                                      ),
                                      const DividerWidget(),
                                      CustomerInformationWidget(
                                        name:
                                            state.tracking.customer?.name ?? '',
                                        address:
                                            state.tracking.customer?.address ??
                                                '',
                                        phone: state.tracking.customer?.phone ??
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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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

  // TODO: Refactor this code.
  String getStatusTitle(String status) {
    switch (status) {
      case 'awaiting_pickup':
        return 'Ready for Pickup';
      case 'in_transit':
        return 'En Route to Destination';
      case 'delivered':
        return 'Successfully Delivered';
      default:
        return '';
    }
  }

  String getStatusDesc(String status) {
    switch (status) {
      case 'awaiting_pickup':
        return 'The vehicle is ready for pickup, and the vendor man will collect it soon.';
      case 'in_transit':
        return 'The vehicle is currently en route to its destination and can be tracked in real time.';
      case 'delivered':
        return 'The vehicle has been successfully delivered to its destination and the handover is complete.';
      default:
        return '';
    }
  }
}
