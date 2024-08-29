import "package:flutter/cupertino.dart";
import "package:go_router/go_router.dart";
import "package:stadium_project/src/core/routes/app_route_names.dart";
import "package:stadium_project/src/feature/home/view/screens/home_screen.dart";

@immutable
final class RouterConfigService {
  const RouterConfigService._();

  static Page<dynamic> _customNavigatorTransitionAnimation(BuildContext context, GoRouterState state, Widget child) =>
      CustomTransitionPage<Object>(
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          final tween = Tween<double>(begin: 0.6, end: 1);
          final sizeAnimation = animation.drive(tween);
          return SizeTransition(
            sizeFactor: sizeAnimation,
            child: child,
          );
        },
        child: child,
      );

  static final GoRouter router = GoRouter(
    initialLocation: AppRouteNames.home,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        name: "HomeScreen",
        path: AppRouteNames.home,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _customNavigatorTransitionAnimation(context, state, const HomeScreen()),
      ),
    ],
  );
}
