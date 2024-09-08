// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AssignmentDetailsPage]
class AssignmentDetailsRoute extends PageRouteInfo<AssignmentDetailsRouteArgs> {
  AssignmentDetailsRoute({
    Key? key,
    required int id,
    required String refNumber,
    List<PageRouteInfo>? children,
  }) : super(
          AssignmentDetailsRoute.name,
          args: AssignmentDetailsRouteArgs(
            key: key,
            id: id,
            refNumber: refNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'AssignmentDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AssignmentDetailsRouteArgs>();
      return AssignmentDetailsPage(
        key: args.key,
        id: args.id,
        refNumber: args.refNumber,
      );
    },
  );
}

class AssignmentDetailsRouteArgs {
  const AssignmentDetailsRouteArgs({
    this.key,
    required this.id,
    required this.refNumber,
  });

  final Key? key;

  final int id;

  final String refNumber;

  @override
  String toString() {
    return 'AssignmentDetailsRouteArgs{key: $key, id: $id, refNumber: $refNumber}';
  }
}

/// generated route for
/// [AssignmentsPage]
class AssignmentsRoute extends PageRouteInfo<void> {
  const AssignmentsRoute({List<PageRouteInfo>? children})
      : super(
          AssignmentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AssignmentsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AssignmentsPage();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [TrackingDetailsPage]
class TrackingDetailsRoute extends PageRouteInfo<TrackingDetailsRouteArgs> {
  TrackingDetailsRoute({
    Key? key,
    required int id,
    required String refNumber,
    List<PageRouteInfo>? children,
  }) : super(
          TrackingDetailsRoute.name,
          args: TrackingDetailsRouteArgs(
            key: key,
            id: id,
            refNumber: refNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'TrackingDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TrackingDetailsRouteArgs>();
      return TrackingDetailsPage(
        key: args.key,
        id: args.id,
        refNumber: args.refNumber,
      );
    },
  );
}

class TrackingDetailsRouteArgs {
  const TrackingDetailsRouteArgs({
    this.key,
    required this.id,
    required this.refNumber,
  });

  final Key? key;

  final int id;

  final String refNumber;

  @override
  String toString() {
    return 'TrackingDetailsRouteArgs{key: $key, id: $id, refNumber: $refNumber}';
  }
}

/// generated route for
/// [TrackingPage]
class TrackingRoute extends PageRouteInfo<void> {
  const TrackingRoute({List<PageRouteInfo>? children})
      : super(
          TrackingRoute.name,
          initialChildren: children,
        );

  static const String name = 'TrackingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TrackingPage();
    },
  );
}

/// generated route for
/// [WelcomePage]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WelcomePage();
    },
  );
}
