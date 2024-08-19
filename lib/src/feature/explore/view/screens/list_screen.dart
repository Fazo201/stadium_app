import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stadium_project/src/feature/main/view/widgets/custom_explore_list_card_widget.dart';

class ListScreen extends ConsumerWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: const Column(
          children: [
            CustomExploreListCardWidget(isAvailable: true,)
          ],
        ),
      ),
    );
  }
}