import 'package:auto_route/auto_route.dart';
import 'package:aw_rostamani/src/features/tracking/presentation/widgets/tracking_list.dart';
import 'package:aw_rostamani/src/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/shared_components/widgets/loader_widget.dart';
import '../../../../core/styles/app_colors.dart';
import '../bloc/bloc.dart';

@RoutePage()
class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  final _bloc = getIt<TrackingBloc>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetTrackingList());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          'Tracking List',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          color: AppColors.blackColor,
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 18.w,
          onPressed: () {
            context.router.maybePop();
          },
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Column(
              children: [
                BlocBuilder<TrackingBloc, TrackingState>(
                  bloc: _bloc,
                  buildWhen: (previous, current) {
                    if (current is GetTrackingLoading ||
                        current is GetTrackingSucceed ||
                        current is GetTrackingFailed) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                  builder: (context, state) {
                    if (state is GetTrackingLoading) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: LoaderWidget(
                                size: 30.w,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state is GetTrackingSucceed) {
                      if (state.trackings.isEmpty == true) {
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "There is no tracking items",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color:
                                          AppColors.whiteColor.withOpacity(0.4),
                                      fontSize: 12.sp,
                                    ),
                              )
                            ],
                          ),
                        );
                      }
                      return Expanded(
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              TrackingListWidget(
                                trackingList: state.trackings,
                                onPressed: (int id, String refNumber) {
                                  context.router.push(
                                    TrackingDetailsRoute(
                                        id: id, refNumber: refNumber),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
