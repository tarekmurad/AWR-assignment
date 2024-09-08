import 'package:dartz/dartz.dart';

import '../../../../core/data/errors/base_error.dart';
import '../../../../core/data/models/results/result.dart';
import '../../domain/entites/tracking.dart';
import '../../domain/repositories/tracking_repository.dart';
import '../dataSources/tracking_data_source.dart';

class TrackingRepositoryImpl implements TrackingRepository {
  final TrackingDataSourceImpl _trackingDataSource;

  TrackingRepositoryImpl(this._trackingDataSource);

  @override
  Future<Result<BaseError, List<Tracking>>> getTracking() async {
    final response = await _trackingDataSource.getTracking();

    if (response!.isRight()) {
      return Result(data: (response as Right<BaseError, List<Tracking>>).value);
    } else {
      return Result(error: (response as Left<BaseError, dynamic>).value);
    }
  }

  @override
  Future<Result<BaseError, Tracking>> getTrackingDetails(int id) async {
    final response = await _trackingDataSource.getTrackingDetails(id);

    if (response!.isRight()) {
      return Result(data: (response as Right<BaseError, Tracking>).value);
    } else {
      return Result(error: (response as Left<BaseError, dynamic>).value);
    }
  }
}
