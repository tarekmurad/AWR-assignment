import 'package:auto_route/auto_route.dart';
import 'package:aw_rostamani/src/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/shared_components/widgets/button_widget.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_dimens.dart';
import '../../../../core/styles/assets.dart';
import 'login/bloc/bloc.dart';

@RoutePage()
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _bloc = getIt<LoginBloc>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('hhh');
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 200.h,
                      width: 300.w,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(Assets.primaryLogo),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 175.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimens.horizontalPadding,
                      ),
                      child: ButtonWidget(
                        onPressed: () {
                          context.router.push(const AssignmentsRoute());
                        },
                        labelText: "Vendor Team",
                        color: AppColors.blackColor,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimens.horizontalPadding,
                      ),
                      child: ButtonWidget(
                        onPressed: () {
                          context.router.push(const TrackingRoute());
                        },
                        labelText: 'AWR Team',
                        color: AppColors.primaryColor,

                        // borderColor: AppColors.primaryColor,
                        // labelColor: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
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
