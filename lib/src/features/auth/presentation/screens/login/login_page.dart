import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:aw_rostamani/src/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

import '../../../../../core/shared_components/widgets/button_widget.dart';
import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/styles/app_dimens.dart';
import '../../../data/models/email.dart';
import '../../../data/models/password.dart';
import '../../widgets/password_text_hint_field_widget.dart';
import '../../widgets/text_hint_field_widget.dart';
import 'bloc/bloc.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _bloc;
  late GlobalKey _scaffoldKey;

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  Timer? _usernameTimeHandle;
  Timer? _passwordTimeHandle;

  @override
  void initState() {
    super.initState();

    _bloc = getIt<LoginBloc>();
    _scaffoldKey = GlobalKey<ScaffoldState>();

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          color: AppColors.primaryColor,
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 18.w,
          onPressed: () {
            context.router.maybePop();
          },
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimens.horizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      "Log in to your account",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppColors.neutral300Color,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      bloc: _bloc,
                      buildWhen: (previous, current) =>
                          previous.email != current.email,
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextHintFieldWidget(
                              textEditingController: _usernameController,
                              hintText: 'Email',
                              onChanged: (text) {
                                if (_usernameTimeHandle?.isActive ?? false) {
                                  _usernameTimeHandle!.cancel();
                                }
                                _usernameTimeHandle = Timer(
                                    const Duration(milliseconds: 250), () {
                                  _bloc.add(LoginEmailChanged(email: text));
                                });
                              },
                              borderColor: state.email.isNotValid &&
                                      state.email.error ==
                                          EmailValidationError.invalid
                                  ? AppColors.redColor
                                  : null,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            if (state.email.error ==
                                    EmailValidationError.empty &&
                                !state.email.isPure)
                              Text(
                                'Email is empty',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: AppColors.primaryColor,
                                      fontSize: 10.sp,
                                    ),
                              )
                            else if (state.email.isNotValid &&
                                state.email.error ==
                                    EmailValidationError.invalid)
                              Text(
                                'Email is incorrect',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: AppColors.redColor,
                                      fontSize: 10.sp,
                                    ),
                              ),
                            SizedBox(
                              height: 5.h,
                            ),
                          ],
                        );
                      },
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      bloc: _bloc,
                      buildWhen: (previous, current) =>
                          previous.password != current.password,
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PasswordTextHintFieldWidget(
                              textEditingController: _passwordController,
                              hintText: 'Password',
                              onChanged: (text) {
                                if (_passwordTimeHandle?.isActive ?? false) {
                                  _passwordTimeHandle!.cancel();
                                }
                                _passwordTimeHandle = Timer(
                                    const Duration(milliseconds: 250), () {
                                  _bloc.add(
                                      LoginPasswordChanged(password: text));
                                });
                              },
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            if (state.password.error ==
                                    PasswordValidationError.empty &&
                                !state.password.isPure)
                              Text(
                                'Password is empty',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: AppColors.primaryColor,
                                        fontSize: 10.sp),
                              )
                            else if (state.password.isNotValid &&
                                state.password.error ==
                                    EmailValidationError.invalid)
                              Text(
                                'Password is empty',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: AppColors.redColor,
                                      fontSize: 10.sp,
                                    ),
                              ),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        // context.router.push(const ForgetPasswordRoute());
                      },
                      child: Center(
                        child: Text(
                          'Forget Password',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    BlocListener<LoginBloc, LoginState>(
                      bloc: _bloc,
                      listener: (context, state) {
                        if (state.status.isFailure) {
                          // showSnackBar(
                          //   context,
                          //   LocaleKeys.err_login_failed.tr(),
                          //   AppColors.warningColor,
                          // );
                        } else if (state.status.isSuccess) {
                          // context.router.replace(const HomeRoute());
                        }
                      },
                      child: BlocBuilder<LoginBloc, LoginState>(
                        bloc: _bloc,
                        buildWhen: (previous, current) =>
                            previous.status != current.status,
                        builder: (context, state) {
                          bool isValidated =
                              // state.status.isValidated &&
                              !state.status.isInProgress;

                          return AbsorbPointer(
                            absorbing: !isValidated,
                            child: ButtonWidget(
                              onPressed: () {
                                if (isValidated) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  _bloc.add(LoginSubmitted());
                                }
                              },
                              loading: state.status.isInProgress,
                              labelText: "Log in with Email",
                              labelColor: isValidated
                                  ? AppColors.whiteColor
                                  : AppColors.primaryColor,
                              color: isValidated
                                  ? AppColors.primaryColor
                                  : AppColors.primary300Color,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account? ",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.neutral1000Color,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // context.router.push(const ForgetPasswordRoute());
                          },
                          child: Center(
                            child: Text(
                              "Sign up",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
