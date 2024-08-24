import 'package:flutter/material.dart';
import 'package:stadium_project/src/core/constants/context_extension.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Favourite",style: context.textTheme.bodyLarge),
      ),
    );
  }
}