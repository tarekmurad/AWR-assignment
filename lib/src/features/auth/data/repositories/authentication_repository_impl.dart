import 'package:dartz/dartz.dart';

import '../../../../core/data/errors/base_error.dart';
import '../../../../core/data/models/results/result.dart';
import '../../../../core/data/prefs_helper.dart';
import '../../domain/entites/authentication.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../dataSources/authentication_data_source.dart';

class AuthRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDataSourceImpl _authenticationDataSource;
  final PrefsHelper _prefsHelper;

  AuthRepositoryImpl(this._authenticationDataSource, this._prefsHelper);

  /// Shared Preferences

  Future<Map<String, dynamic>> getAllDate() => _prefsHelper.getAllDate();

  Future<bool> clearUserInfo() => _prefsHelper.clearData();

  Future<String> getUserToken() => _prefsHelper.getUserToken();

  Future<int> getUserId() => _prefsHelper.getUserId();

  Future<String> getAppLanguage() => _prefsHelper.getAppLanguage();

  Future<String> getAppGUID() => _prefsHelper.getAppGUID();

  void saveUserToken(String? token) => _prefsHelper.saveUserToken(token);

  void saveUserRefreshToken(String? userRefreshToken) =>
      _prefsHelper.saveUserRefreshToken(userRefreshToken);

  void saveUserTokenType(String? userTokenType) =>
      _prefsHelper.saveUserTokenType(userTokenType);

  void saveUserId(int? id) => _prefsHelper.saveUserId(id);

  void saveAppLanguage(String lang) => _prefsHelper.saveAppLanguage(lang);

  void saveAppGUID(String appGUID) => _prefsHelper.saveAppGUID(appGUID);

  @override
  Future<Result<BaseError, Authentication>> login(
      String email, String password) async {
    final response = await _authenticationDataSource.login(email, password);

    if (response!.isRight()) {
      return Result(data: (response as Right<BaseError, Authentication>).value);
    } else {
      return Result(error: (response as Left<BaseError, dynamic>).value);
    }
  }
}
