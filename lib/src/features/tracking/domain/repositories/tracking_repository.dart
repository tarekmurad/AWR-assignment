import '../../../../core/data/errors/base_error.dart';
import '../../../../core/data/models/results/result.dart';
import '../entites/tracking.dart';

abstract class TrackingRepository {
  Future<Result<BaseError, List<Tracking>>> getTracking();

  Future<Result<BaseError, Tracking>> getTrackingDetails(int id);
}
