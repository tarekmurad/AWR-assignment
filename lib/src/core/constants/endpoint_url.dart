import 'app_url.dart';

class EndpointUrl {
  EndpointUrl._();

  /// Authentication
  static String loginUrl = '${AppUrl.baseUrlApi}auth/signin';
  static String refreshTokenUrl = '${AppUrl.baseUrlApi}auth/refresh-token';
}
