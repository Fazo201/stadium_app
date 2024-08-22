import "package:flutter/cupertino.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:stadium_project/src/core/routes/app_route_names.dart";

final primaryVM = ChangeNotifierProvider((ref) => PrimaryVM());

class PrimaryVM with ChangeNotifier {
  int currentIndex = 0;

  void changeNavigation(BuildContext context, int index) {
    currentIndex = index;
    switch (index) {
      case 0:
        context.go(AppRouteNames.explore);
        break;
      case 1:
        context.go(AppRouteNames.favourite);
        break;
      case 2:
        context.go(AppRouteNames.account);
        break;
      default:
    }
    notifyListeners();
  }
}
