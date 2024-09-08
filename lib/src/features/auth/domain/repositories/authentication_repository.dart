import '../../../../core/data/errors/base_error.dart';
import '../../../../core/data/models/results/result.dart';
import '../entites/authentication.dart';

abstract class AuthenticationRepository {
  Future<Result<BaseError, Authentication>> login(
      String email, String password);
}
