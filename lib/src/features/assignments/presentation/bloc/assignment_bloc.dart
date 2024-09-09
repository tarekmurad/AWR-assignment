import 'package:aw_rostamani/src/core/usecase/usecase.dart';
import 'package:aw_rostamani/src/features/assignments/domain/usecases/get_assignment_details.dart';
import 'package:aw_rostamani/src/injection_container.dart';
import 'package:bloc/bloc.dart';

import '../../domain/repositories/assignment_repository.dart';
import '../../domain/usecases/get_assignment.dart';
import 'bloc.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  AssignmentBloc() : super(InitialAssignmentState()) {
    on<GetAssignmentList>(_onGetAssignmentList);
    on<GetAssignmentDetailsEvent>(_onGetAssignmentDetails);
    on<StartTripEvent>(_onStartTripEvent);
    on<EndTripEvent>(_onEndTripEvent);
  }

  void _onGetAssignmentList(
    GetAssignmentList event,
    Emitter<AssignmentState> emit,
  ) async {
    emit(GetAssignmentLoading());

    final result =
        await GetAssignment(getIt<AssignmentRepository>()).call(NoParams());

    if (result.hasDataOnly) {
      emit(GetAssignmentSucceed(result.data ?? []));
    } else if (result.hasErrorOnly) {
      emit(GetAssignmentFailed());
    }
  }

  void _onGetAssignmentDetails(
    GetAssignmentDetailsEvent event,
    Emitter<AssignmentState> emit,
  ) async {
    emit(GetAssignmentDetailsLoading());

    final result = await GetAssignmentDetails(getIt<AssignmentRepository>())
        .call(Params(id: event.id));

    if (result.hasDataOnly) {
      emit(GetAssignmentDetailsSucceed(result.data!));
    } else if (result.hasErrorOnly) {
      emit(GetAssignmentDetailsFailed());
    }
  }

  void _onStartTripEvent(
    StartTripEvent event,
    Emitter<AssignmentState> emit,
  ) async {
    emit(StartTripLoading());

    // TODO: This should call an API to start the trip, but we will simulate it here for now.
    await Future.delayed(const Duration(seconds: 2));
    if (true) {
      emit(StartTripSucceed());
    } else if (false) {
      emit(StartTripFailed());
    }
  }

  void _onEndTripEvent(
    EndTripEvent event,
    Emitter<AssignmentState> emit,
  ) async {
    emit(EndTripLoading());

    // TODO: This should call an API to end the trip, but we will simulate it here for now.
    await Future.delayed(const Duration(seconds: 2));
    if (true) {
      emit(EndTripSucceed());
    } else if (false) {
      emit(EndTripFailed());
    }
  }
}
