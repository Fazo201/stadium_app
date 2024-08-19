import "package:flutter/material.dart";
import "package:stadium_project/src/core/routes/router_config.dart";
import "package:stadium_project/src/feature/settings/inherited_theme_notifier.dart";
import "package:stadium_project/src/feature/settings/theme_controller.dart";

final ThemeController themeController = ThemeController();

class AppMaterialContext extends StatelessWidget {
  const AppMaterialContext({super.key});

  @override
  Widget build(BuildContext context) => InheritedThemeNotifier(
        themeController: themeController,
        child:  Builder(
          builder: (context) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: InheritedThemeNotifier.maybeOf(context)?.theme,
            routerConfig: RouterConfigService.router,
          ),
        ),
      );
}
