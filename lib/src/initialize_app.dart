import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'core/utils/global_config.dart';
import 'injection_container.dart';

enum Environment {
  dev,
  stage,
  prod,
}

class InitializeApp {
  factory InitializeApp() {
    return _initializeApp;
  }

  InitializeApp._internal();

  static final InitializeApp _initializeApp = InitializeApp._internal();

  Future<void> initApp(Environment env) async {
    WidgetsFlutterBinding.ensureInitialized();

    await EasyLocalization.ensureInitialized();

    /// Initialize injection container
    setupLocator();

    // await FirebaseNotifications().initFirebase();

    ///
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    /// load our config
    await GlobalConfig.forEnvironment(env);
  }
}
