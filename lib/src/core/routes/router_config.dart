import "package:flutter/cupertino.dart";
import "package:go_router/go_router.dart";
import "package:stadium_project/src/core/routes/app_route_names.dart";
import "package:stadium_project/src/feature/account/account_screen.dart";
import "package:stadium_project/src/feature/explore/view/screens/explore_screen.dart";
import "package:stadium_project/src/feature/favourite/favourite_screen.dart";
import "package:stadium_project/src/feature/main/view/screens/primary_screen.dart";


// GlobalKey<NavigatorState> parentNavigatorKey = GlobalKey<NavigatorState>();

@immutable
final class RouterConfigService {
  const RouterConfigService._();

  // static final GoRoute foodDetails = GoRoute(
  //   parentNavigatorKey: parentNavigatorKey,
  //   path: AppRouteNames.foodDetails,
  //   pageBuilder: (BuildContext context, GoRouterState state) => _customEachTransitionAnimation(context, state, const FoodDetailsPage()),
  //   routes: [reviews],
  // );

  // static final GoRoute reviews = GoRoute(
  //   parentNavigatorKey: parentNavigatorKey,
  //   path: AppRouteNames.reviews,
  //   pageBuilder: (BuildContext context, GoRouterState state) => _customEachTransitionAnimation(context, state, const ReviewsPage()),
  // );

  static Page<dynamic> _customNavigatorTransitionAnimation(BuildContext context, GoRouterState state, Widget child) =>
      CustomTransitionPage<Object>(
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          // var begin = Offset(1.0, 0.0); // From right
          // var end = Offset.zero;
          // var tween = Tween(begin: begin, end: end);
          // var offsetAnimation = animation.drive(tween);
          //
          // return SlideTransition(
          //   position: offsetAnimation,
          //   child: child,
          // );

          // var tween = Tween<double>(begin: 0, end: 1);
          // var scaleAnimation = animation.drive(tween);
          //
          // return ScaleTransition(
          //   scale: scaleAnimation,
          //   child: child,
          // );

          final tween = Tween<double>(begin: 0.6, end: 1);
          final sizeAnimation = animation.drive(tween);

          return SizeTransition(
            sizeFactor: sizeAnimation,
            child: child,
          );

          // var tween = Tween<double>(begin: 0.5, end: 1); // Full rotation
          // var rotationAnimation = animation.drive(tween);
          //
          // return RotationTransition(
          //   turns: rotationAnimation,
          //   child: child,
          // );

          // return FadeTransition(
          //   opacity: animation,
          //   child: child,
          // );
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
            // routes: [
            //   // search page
            //   search,
            //   // food detail page
            //   foodDetails,
            // ],
          ),

          /// Favourite
          GoRoute(
            name: "FavouriteScreen",
            path: AppRouteNames.favourite,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                _customNavigatorTransitionAnimation(context, state, const FavouriteScreen()),
          ),

          /// Account
          GoRoute(
            name: "AccountScreen",
            path: AppRouteNames.account,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                _customNavigatorTransitionAnimation(context, state, const AccountScreen()),
          ),
        ],
      ),
    ],
  );
}
