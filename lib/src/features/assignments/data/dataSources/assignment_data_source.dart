import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../../../core/data/errors/base_error.dart';
import '../../../../core/data/http_helper.dart';
import '../../../../core/data/models/responses/list_response.dart';
import '../../../../core/data/models/responses/object_response.dart';
import '../models/assignment_model.dart';

abstract class AssignmentDataSource {
  Future<Either<BaseError, List<AssignmentModel>>>? getAssignment();

  Future<Either<BaseError, AssignmentModel>>? getAssignmentDetails(int id);
}

class AssignmentDataSourceImpl extends AssignmentDataSource {
  final HttpHelper _httpHelper;

  AssignmentDataSourceImpl(this._httpHelper);

  Future<Map<String, dynamic>> _loadJson(String path) async {
    final String jsonString = await rootBundle.loadString(path);
    return json.decode(jsonString);
  }

  // TODO: This should be an API call to the server
  @override
  Future<Either<BaseError, List<AssignmentModel>>>? getAssignment() async {
    await Future.delayed(const Duration(seconds: 2));

    final responseData = await _loadJson('assets/data/get_assignments.json');

    final listResponse = ListResponse.fromJson(responseData);

    final assignmentListResponse = (listResponse.data as List)
        .map((item) => AssignmentModel.fromJson(item))
        .toList();

    return Right(assignmentListResponse);
  }

  // TODO: This should be an API call to the server
  @override
  Future<Either<BaseError, AssignmentModel>>? getAssignmentDetails(
      int id) async {
    await Future.delayed(const Duration(seconds: 2));

    final responseData =
        await _loadJson('assets/data/get_assignment_details_$id.json');

    final listResponse = ObjectResponse.fromJson(responseData);

    final assignmentResponse =
        AssignmentModel.fromJson(listResponse.data as Map<String, dynamic>);

    return Right(assignmentResponse);
  }
}
