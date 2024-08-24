import 'package:flutter/material.dart';
import 'package:stadium_project/src/core/constants/context_extension.dart';
import 'package:stadium_project/src/core/widgets/app_material_context.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: () {
            themeController.switchTheme();
          },
          icon: Icon(
            themeController.isLight ? Icons.dark_mode_rounded : Icons.light_mode,
            color: context.theme.colorScheme.surfaceTint,
            size: 54,
          ),
        ),
      ),
    );
  }
}
