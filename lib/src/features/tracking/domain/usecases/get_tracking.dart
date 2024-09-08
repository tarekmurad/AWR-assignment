import '../../../../core/data/errors/base_error.dart';
import '../../../../core/data/models/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entites/tracking.dart';
import '../repositories/tracking_repository.dart';

class GetTracking implements UseCase<List<Tracking>, NoParams> {
  final TrackingRepository repository;

  GetTracking(this.repository);

  @override
  Future<Result<BaseError, List<Tracking>>> call(NoParams params) async {
    return await repository.getTracking();
  }
}
