import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../../../core/data/errors/base_error.dart';
import '../../../../core/data/http_helper.dart';
import '../../../../core/data/models/responses/list_response.dart';
import '../../../../core/data/models/responses/object_response.dart';
import '../models/tracking_model.dart';

abstract class TrackingDataSource {
  Future<Either<BaseError, List<TrackingModel>>>? getTracking();

  Future<Either<BaseError, TrackingModel>>? getTrackingDetails(int id);
}

class TrackingDataSourceImpl extends TrackingDataSource {
  final HttpHelper _httpHelper;

  TrackingDataSourceImpl(this._httpHelper);

  Future<Map<String, dynamic>> _loadJson(String path) async {
    final String jsonString = await rootBundle.loadString(path);
    return json.decode(jsonString);
  }

  @override
  Future<Either<BaseError, List<TrackingModel>>>? getTracking() async {
    await Future.delayed(const Duration(seconds: 3));

    final responseData = await _loadJson('assets/data/get_tracking_list.json');

    final listResponse = ListResponse.fromJson(responseData);
    final trackingListResponse = (listResponse.data as List)
        .map((item) => TrackingModel.fromJson(item))
        .toList();

    return Right(trackingListResponse);
  }

  @override
  Future<Either<BaseError, TrackingModel>>? getTrackingDetails(int id) async {
    await Future.delayed(const Duration(seconds: 2));

    final responseData =
        await _loadJson('assets/data/get_tracking_details_$id.json');

    final listResponse = ObjectResponse.fromJson(responseData);
    final trackingResponse =
        TrackingModel.fromJson(listResponse.data as Map<String, dynamic>);

    return Right(trackingResponse);
  }
}
