import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import '../../features/assignments/presentation/screens/assignment_details_page.dart';
import '../../features/assignments/presentation/screens/assignments_page.dart';
import '../../features/auth/presentation/screens/login/login_page.dart';
import '../../features/auth/presentation/screens/welcome_page.dart';
import '../../features/tracking/presentation/screens/tracking_details_page.dart';
import '../../features/tracking/presentation/screens/tracking_list_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: WelcomeRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: AssignmentsRoute.page),
    AutoRoute(page: AssignmentDetailsRoute.page),
    AutoRoute(page: TrackingRoute.page),
    AutoRoute(page: TrackingDetailsRoute.page),
  ];
}
