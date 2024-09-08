import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class TrackingEvent {}

class GetTrackingList extends TrackingEvent {}

class GetTrackingDetailsEvent extends TrackingEvent {
  final int id;

  GetTrackingDetailsEvent({
    required this.id,
  });
}

class StartTripEvent extends TrackingEvent {
  final int id;

  StartTripEvent({
    required this.id,
  });
}

class EndTripEvent extends TrackingEvent {
  final int id;

  EndTripEvent({
    required this.id,
  });
}

class LocationUpdatedEvent extends TrackingEvent {
  final LatLng location;

  LocationUpdatedEvent({
    required this.location,
  });
}
