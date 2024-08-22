import "package:flutter/cupertino.dart";
import "package:go_router/go_router.dart";
import "package:stadium_project/src/core/routes/app_route_names.dart";
import "package:stadium_project/src/feature/account/account_screen.dart";
import "package:stadium_project/src/feature/explore/view/screens/explore_screen.dart";
import "package:stadium_project/src/feature/favourite/favourite_screen.dart";
import "package:stadium_project/src/feature/main/view/screens/primary_screen.dart";


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
    initialLocation: AppRouteNames.explore,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      ShellRoute(
        builder: (context, state, child) => PrimaryScreen(child),
        routes: [
          /// Explore
          GoRoute(
            name: "ExploreScreen",
            path: AppRouteNames.explore,
            pageBuilder: (BuildContext context, GoRouterState state) => _customNavigatorTransitionAnimation(context, state, const ExploreScreen()),
          ),

          /// Favourite
          GoRoute(
            name: "FavouriteScreen",
            path: AppRouteNames.favourite,
            pageBuilder: (BuildContext context, GoRouterState state) => _customNavigatorTransitionAnimation(context, state, const FavouriteScreen()),
          ),

          /// Account
          GoRoute(
            name: "AccountScreen",
            path: AppRouteNames.account,
            pageBuilder: (BuildContext context, GoRouterState state) => _customNavigatorTransitionAnimation(context, state, const AccountScreen()),
          ),
        ],
      ),
    ],
  );
}
