import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/entites/tracking.dart';

abstract class TrackingState {}

class InitialTrackingState extends TrackingState {}

/// Get tracking

class GetTrackingLoading extends TrackingState {}

class GetTrackingSucceed extends TrackingState {
  final List<Tracking> trackings;

  GetTrackingSucceed(this.trackings);
}

class GetTrackingFailed extends TrackingState {
  final String? message;

  GetTrackingFailed({this.message});
}

/// Get tracking details

class GetTrackingDetailsLoading extends TrackingState {}

class GetTrackingDetailsSucceed extends TrackingState {
  final Tracking tracking;

  GetTrackingDetailsSucceed(this.tracking);
}

class GetTrackingDetailsFailed extends TrackingState {
  final String? message;

  GetTrackingDetailsFailed({this.message});
}

///

class TrackingLocationUpdated extends TrackingState {
  final LatLng location;

  TrackingLocationUpdated({
    required this.location,
  });
}
