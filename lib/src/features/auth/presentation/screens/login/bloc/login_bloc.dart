import 'package:aw_rostamani/src/injection_container.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';

import '../../../../data/models/email.dart';
import '../../../../data/models/password.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../../../domain/usecases/login.dart';
import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);

    emit(state.copyWith(
      email: email,
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
    ));
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      final logInResult = await Login(getIt<AuthenticationRepository>()).call(
          Params(email: state.email.value, password: state.password.value));

      if (logInResult.hasDataOnly) {
        // Authentication authentication = Authentication.fromJson(
        //     (logInResult.data! as ObjectResponse).data!);
        //
        // getIt<GlobalConfig>().currentUser = authentication;
      } else if (logInResult.hasErrorOnly) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
