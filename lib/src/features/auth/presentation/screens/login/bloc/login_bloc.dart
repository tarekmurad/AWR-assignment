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
  // final AuthRepositoryImpl _authenticationRepository;
  // Login login;

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
      // status: Formz.validate([email, state.password])
      //     ? FormzSubmissionStatus.success
      //     : FormzSubmissionStatus.failure,
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      // status: Formz.validate([state.email, password])
      //     ? FormzSubmissionStatus.success
      //     : FormzSubmissionStatus.failure,
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
        // _authenticationRepository.saveUserToken(authentication.token);
        // _authenticationRepository
        //     .saveUserRefreshToken(authentication.refreshToken);
        // _authenticationRepository.saveUserTokenType(authentication.type);
        // _authenticationRepository.saveUserId(authentication.id);
        //
        // String appGUID = await _authenticationRepository.getAppGUID();
        // if (appGUID.isEmpty) {
        //   _authenticationRepository.saveAppGUID(await Helper.getAppGUID());
        // }

        await _onUpdateFireBaseToken(emit);
      } else if (logInResult.hasErrorOnly) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> _onUpdateFireBaseToken(
    Emitter<LoginState> emit,
  ) async {
    String? firebaseToken;

    // await FirebaseMessaging.instance.getToken().then((token) {
    //   debugPrint('Firebase token: $token');
    //   firebaseToken = token;
    // });

    // String appGUID = await _authenticationRepository.getAppGUID();
    //
    // final updateFirebaseTokenResult = await _authenticationRepository
    //     .updateFirebaseToken(UpdateFirebaseTokenParam(
    //   firebaseToken: firebaseToken,
    //   deviceId: appGUID,
    // ));

    // if (updateFirebaseTokenResult.hasDataOnly) {
    //   emit(state.copyWith(status: FormzSubmissionStatus.success));
    // } else if (updateFirebaseTokenResult.hasErrorOnly) {
    //   emit(state.copyWith(status: FormzSubmissionStatus.failure));
    // }
  }
}
