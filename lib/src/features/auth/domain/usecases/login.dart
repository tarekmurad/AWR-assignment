import 'package:equatable/equatable.dart';

import '../../../../core/data/errors/base_error.dart';
import '../../../../core/data/models/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entites/authentication.dart';
import '../repositories/authentication_repository.dart';

class Login implements UseCase<Authentication, Params> {
  final AuthenticationRepository repository;

  Login(this.repository);

  @override
  Future<Result<BaseError, Authentication>> call(Params params) async {
    return await repository.login(params.email, params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  const Params({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
