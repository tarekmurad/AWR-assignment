import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/constants/endpoint_url.dart';
import '../../../../core/data/errors/base_error.dart';
import '../../../../core/data/http_helper.dart';

abstract class AuthenticationDataSource {
  Future<Either<BaseError, dynamic>>? login(String email, String password);
}

class AuthenticationDataSourceImpl extends AuthenticationDataSource {
  final HttpHelper _httpHelper;

  AuthenticationDataSourceImpl(this._httpHelper);

  /// User

  @override
  Future<Either<BaseError, dynamic>>? login(
      String email, String password) async {
    final response = await _httpHelper.postRequest(
      EndpointUrl.loginUrl,
      data: {
        'email': email,
        'password': password,
      },
      withAuthentication: false,
    );

    return Right(response);
  }
}
