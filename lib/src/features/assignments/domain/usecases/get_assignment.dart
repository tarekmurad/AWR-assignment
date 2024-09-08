import '../../../../core/data/errors/base_error.dart';
import '../../../../core/data/models/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entites/assignment.dart';
import '../repositories/assignment_repository.dart';

class GetAssignment implements UseCase<List<Assignment>, NoParams> {
  final AssignmentRepository repository;

  GetAssignment(this.repository);

  @override
  Future<Result<BaseError, List<Assignment>>> call(NoParams params) async {
    return await repository.getAssignment();
  }
}
