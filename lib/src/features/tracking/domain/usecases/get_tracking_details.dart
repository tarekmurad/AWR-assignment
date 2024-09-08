import 'package:equatable/equatable.dart';

import '../../../../core/data/errors/base_error.dart';
import '../../../../core/data/models/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entites/tracking.dart';
import '../repositories/tracking_repository.dart';

class GetTrackingDetails implements UseCase<Tracking, Params> {
  final TrackingRepository repository;

  GetTrackingDetails(this.repository);

  @override
  Future<Result<BaseError, Tracking>> call(Params params) async {
    return await repository.getTrackingDetails(params.id);
  }
}

class Params extends Equatable {
  final int id;

  const Params({required this.id});

  @override
  List<Object> get props => [id];
}
