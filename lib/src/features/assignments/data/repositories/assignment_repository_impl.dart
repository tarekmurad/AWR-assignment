import 'package:dartz/dartz.dart';

import '../../../../core/data/errors/base_error.dart';
import '../../../../core/data/models/results/result.dart';
import '../../domain/entites/assignment.dart';
import '../../domain/repositories/assignment_repository.dart';
import '../dataSources/assignment_data_source.dart';

class AssignmentRepositoryImpl implements AssignmentRepository {
  final AssignmentDataSourceImpl _assignmentDataSource;

  AssignmentRepositoryImpl(this._assignmentDataSource);

  @override
  Future<Result<BaseError, List<Assignment>>> getAssignment() async {
    final response = await _assignmentDataSource.getAssignment();

    if (response!.isRight()) {
      return Result(
          data: (response as Right<BaseError, List<Assignment>>).value);
    } else {
      return Result(error: (response as Left<BaseError, dynamic>).value);
    }
  }

  @override
  Future<Result<BaseError, Assignment>> getAssignmentDetails(int id) async {
    final response = await _assignmentDataSource.getAssignmentDetails(id);

    if (response!.isRight()) {
      return Result(data: (response as Right<BaseError, Assignment>).value);
    } else {
      return Result(error: (response as Left<BaseError, dynamic>).value);
    }
  }
}
