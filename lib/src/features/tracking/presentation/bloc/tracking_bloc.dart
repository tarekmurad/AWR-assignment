import 'dart:async';

import 'package:aw_rostamani/src/core/usecase/usecase.dart';
import 'package:aw_rostamani/src/injection_container.dart';
import 'package:bloc/bloc.dart';

import '../../domain/repositories/tracking_repository.dart';
import '../../domain/usecases/get_tracking.dart';
import '../../domain/usecases/get_tracking_details.dart';
import 'bloc.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  // final LocationService _locationService;
  // late StreamSubscription<LatLng> _locationSubscription;

  TrackingBloc() : super(InitialTrackingState()) {
    on<GetTrackingList>(_onGetTrackingList);
    on<GetTrackingDetailsEvent>(_onGetTrackingDetails);
    on<LocationUpdatedEvent>(_onLocationUpdatedEvent);

    // _locationSubscription = _locationService.locationStream.listen((location) {
    //   add(LocationUpdatedEvent(location: location));
    // });
  }

  void _onGetTrackingList(
    GetTrackingList event,
    Emitter<TrackingState> emit,
  ) async {
    emit(GetTrackingLoading());

    final result =
        await GetTracking(getIt<TrackingRepository>()).call(NoParams());

    if (result.hasDataOnly) {
      emit(GetTrackingSucceed(result.data ?? []));
    } else if (result.hasErrorOnly) {
      emit(GetTrackingFailed());
    }
  }

  void _onGetTrackingDetails(
    GetTrackingDetailsEvent event,
    Emitter<TrackingState> emit,
  ) async {
    emit(GetTrackingDetailsLoading());

    final result = await GetTrackingDetails(getIt<TrackingRepository>())
        .call(Params(id: event.id));

    if (result.hasDataOnly) {
      emit(GetTrackingDetailsSucceed(result.data!));
    } else if (result.hasErrorOnly) {
      emit(GetTrackingDetailsFailed());
    }
  }

  void _onLocationUpdatedEvent(
    LocationUpdatedEvent event,
    Emitter<TrackingState> emit,
  ) async {
    emit(TrackingLocationUpdated(location: event.location));
  }

  @override
  Future<void> close() {
    // _locationSubscription.cancel();
    return super.close();
  }
}
