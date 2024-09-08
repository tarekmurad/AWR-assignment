import '../../domain/entites/assignment.dart';

abstract class AssignmentState {}

class InitialAssignmentState extends AssignmentState {}

/// Get assignments

class GetAssignmentLoading extends AssignmentState {}

class GetAssignmentSucceed extends AssignmentState {
  final List<Assignment> assignments;

  GetAssignmentSucceed(this.assignments);
}

class GetAssignmentFailed extends AssignmentState {
  final String? message;

  GetAssignmentFailed({this.message});
}

/// Get assignments details

class GetAssignmentDetailsLoading extends AssignmentState {}

class GetAssignmentDetailsSucceed extends AssignmentState {
  final Assignment assignment;

  GetAssignmentDetailsSucceed(this.assignment);
}

class GetAssignmentDetailsFailed extends AssignmentState {
  final String? message;

  GetAssignmentDetailsFailed({this.message});
}

/// Start trip

class StartTripLoading extends AssignmentState {}

class StartTripSucceed extends AssignmentState {}

class StartTripFailed extends AssignmentState {
  final String? message;

  StartTripFailed({this.message});
}

/// End trip

class EndTripLoading extends AssignmentState {}

class EndTripSucceed extends AssignmentState {}

class EndTripFailed extends AssignmentState {
  final String? message;

  EndTripFailed({this.message});
}
