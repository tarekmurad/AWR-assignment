import 'package:auto_route/auto_route.dart';
import 'package:aw_rostamani/src/features/assignments/presentation/widgets/assignment_list.dart';
import 'package:aw_rostamani/src/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/shared_components/widgets/loader_widget.dart';
import '../../../../core/styles/app_colors.dart';
import '../bloc/bloc.dart';

@RoutePage()
class AssignmentsPage extends StatefulWidget {
  const AssignmentsPage({super.key});

  @override
  _AssignmentsPageState createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  final _bloc = getIt<AssignmentBloc>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetAssignmentList());
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
          'My Assignments',
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
                BlocBuilder<AssignmentBloc, AssignmentState>(
                  bloc: _bloc,
                  buildWhen: (previous, current) {
                    if (current is GetAssignmentLoading ||
                        current is GetAssignmentSucceed ||
                        current is GetAssignmentFailed) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                  builder: (context, state) {
                    if (state is GetAssignmentLoading) {
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
                    } else if (state is GetAssignmentSucceed) {
                      if (state.assignments.isEmpty == true) {
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "There is no assignments",
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
                              AssignmentListWidget(
                                assignments: state.assignments,
                                onPressed: (int id, String refNumber) {
                                  context.router.push(
                                    AssignmentDetailsRoute(
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
