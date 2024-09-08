import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:aw_rostamani/src/core/shared_components/widgets/vehicle_information_widget.dart';
import 'package:aw_rostamani/src/features/tracking/presentation/widgets/customer_information_widget.dart';
import 'package:aw_rostamani/src/features/tracking/presentation/widgets/vendor_info_widget.dart';
import 'package:aw_rostamani/src/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/shared_components/widgets/divider.dart';
import '../../../../core/shared_components/widgets/loader_widget.dart';
import '../../../../core/shared_components/widgets/location_details_widget.dart';
import '../../../../core/shared_components/widgets/status_widget.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_dimens.dart';
import '../../../../core/styles/assets.dart';
import '../../../../core/utils/helpers.dart';
import '../bloc/bloc.dart';

@RoutePage()
class TrackingDetailsPage extends StatefulWidget {
  final int id;
  final String refNumber;

  const TrackingDetailsPage(
      {Key? key, required this.id, required this.refNumber})
      : super(key: key);

  @override
  _TrackingDetailsPageState createState() => _TrackingDetailsPageState();
}

class _TrackingDetailsPageState extends State<TrackingDetailsPage> {
  final _bloc = getIt<TrackingBloc>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final Location _location = Location();
  GoogleMapController? mapController;
  Marker? currentLocationMarker;
  Marker? sourceMarker;
  Marker? destinationMarker;
  Polyline? routePolyline;
  int currentIndex = 0;
  Timer? timer;
  String _mapStyle = '';

  List<LatLng> routePoints = [
    const LatLng(25.199429016702688, 55.27507425522772),
    const LatLng(25.19976128047399, 55.276659164149194),
    const LatLng(25.20070497201089, 55.27766121830333),
    const LatLng(25.201186066842276, 55.27798841965977),
    const LatLng(25.203054917190016, 55.27434830456928),
    const LatLng(25.20383205443402, 55.273448500839045),
    const LatLng(25.204202118044694, 55.273019049058696),
    const LatLng(25.20564535537731, 55.27203744498936),
    const LatLng(25.20675552629728, 55.27254869710881),
    const LatLng(25.207366116082866, 55.2729576989926),
    const LatLng(25.209715932677284, 55.274573255690065),
    const LatLng(25.211048092013147, 55.27512540797907),
    const LatLng(25.213286826940653, 55.276802314930876),
    const LatLng(25.214581944169165, 55.27759986843855),
    const LatLng(25.216765110367298, 55.27901092428824),
    const LatLng(25.217671667870974, 55.279726677255475),
    const LatLng(25.22037279915831, 55.28156718488549),
    const LatLng(25.222763237996826, 55.283280941878516),
    const LatLng(25.224313602741155, 55.28436941678441),
    const LatLng(25.226000125846504, 55.28551578961238),
    const LatLng(25.228074202796442, 55.28700954772792),
    const LatLng(25.22907980312968, 55.28863068056648),
    const LatLng(25.22984447287571, 55.29112027782615),
    const LatLng(25.230724360812246, 55.29460571342907),
    const LatLng(25.231363323061082, 55.2972805826127),
    const LatLng(25.231862921912413, 55.30041593289329),
    const LatLng(25.232288192129012, 55.30221095772743),
    const LatLng(25.2328809905551, 55.303336409805986),
    const LatLng(25.234856780823655, 55.30460501011074),
    const LatLng(25.236487150650063, 55.30518375798757),
    const LatLng(25.238715786098915, 55.306043612483016),
    const LatLng(25.240226448537836, 55.30782946307436),
    const LatLng(25.241108906027172, 55.30854049618017),
    const LatLng(25.243935718234663, 55.31105391553096),
    const LatLng(25.247450446082336, 55.313964191222574),
    const LatLng(25.24876657326917, 55.31745321413715),
    const LatLng(25.249768615090122, 55.31917292211401),
    const LatLng(25.251727807309422, 55.320958772705346),
    const LatLng(25.257934200176077, 55.326399003505976),
    const LatLng(25.258038883597944, 55.328763601974146),
    const LatLng(25.257904290610373, 55.33003684730316),
    const LatLng(25.25759023972598, 55.33097937955971),
    const LatLng(25.25998298797378, 55.3325171957663),
  ];

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    _initializeMarkers();

    _bloc.add(GetTrackingDetailsEvent(id: widget.id));

    DefaultAssetBundle.of(context)
        .loadString('assets/styles/map_style.json')
        .then((style) {
      _mapStyle = style;
    });
  }

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }
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
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.w,
                                          vertical: 14.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.cardColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimens.itemRadius),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 21.w,
                                              width: 21.w,
                                              child: SvgPicture.asset(
                                                Assets.statusIcon,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 12.w,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    getStatusTitle(
                                                        state.tracking.status ??
                                                            ''),
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color:
                                                          AppColors.blackColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Text(
                                                    getStatusDesc(
                                                        state.tracking.status ??
                                                            ''),
                                                    style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color:
                                                          AppColors.grayColor,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
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

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

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
