abstract class AssignmentEvent {}

class GetAssignmentList extends AssignmentEvent {}

class GetAssignmentDetailsEvent extends AssignmentEvent {
  final int id;

  GetAssignmentDetailsEvent({
    required this.id,
  });
}

class StartTripEvent extends AssignmentEvent {
  final int id;

  StartTripEvent({
    required this.id,
  });
}

class EndTripEvent extends AssignmentEvent {
  final int id;

  EndTripEvent({
    required this.id,
  });
}
