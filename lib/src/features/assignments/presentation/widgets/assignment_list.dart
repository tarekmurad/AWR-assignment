import 'package:flutter/material.dart';

import '../../domain/entites/assignment.dart';
import 'assignment_item.dart';

class AssignmentListWidget extends StatelessWidget {
  final List<Assignment> assignments;
  final Function(int, String) onPressed;

  const AssignmentListWidget({
    super.key,
    required this.assignments,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: assignments.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return AssignmentItemWidget(
          assignment: assignments[index],
          onPressed: () {
            onPressed(assignments[index].id!, assignments[index].ref!);
          },
        );
      },
    );
  }
}
