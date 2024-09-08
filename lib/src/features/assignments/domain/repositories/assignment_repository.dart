import '../../../../core/data/errors/base_error.dart';
import '../../../../core/data/models/results/result.dart';
import '../entites/assignment.dart';

abstract class AssignmentRepository {
  Future<Result<BaseError, List<Assignment>>> getAssignment();

  Future<Result<BaseError, Assignment>> getAssignmentDetails(int id);
}
