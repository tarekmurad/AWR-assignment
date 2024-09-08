import 'dart:convert';

import 'package:aw_rostamani/src/features/auth/domain/entites/authentication.dart';
import 'package:aw_rostamani/src/initialize_app.dart';
import 'package:flutter/services.dart';

import '../constants/app_url.dart';
import '../constants/constants.dart';

class GlobalConfig {
  factory GlobalConfig() {
    return _globalConfig;
  }

  GlobalConfig._internal();

  static final GlobalConfig _globalConfig = GlobalConfig._internal();

  /// firebase messaging permission
  bool isNotificationPermissionEnabledFromUser = true;

  /// current language of the app
  String currentLanguage = Constants.englishLanguage;

  /// login status
  bool isUserLoggedIn = true;

  /// current logged user
  Authentication? currentUser;

  static Future<void> forEnvironment(Environment env) async {
    final contents = await rootBundle.loadString(
      'assets/config/${env.name}.json',
    );

    final json = jsonDecode(contents);

    AppUrl.baseUrl = json['base_url'];
  }
}
