import 'package:equatable/equatable.dart';

import '../../../../core/data/errors/base_error.dart';
import '../../../../core/data/models/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entites/assignment.dart';
import '../repositories/assignment_repository.dart';

class GetAssignmentDetails implements UseCase<Assignment, Params> {
  final AssignmentRepository repository;

  GetAssignmentDetails(this.repository);

  @override
  Future<Result<BaseError, Assignment>> call(Params params) async {
    return await repository.getAssignmentDetails(params.id);
  }
}

class Params extends Equatable {
  final int id;

  const Params({required this.id});

  @override
  List<Object> get props => [id];
}
