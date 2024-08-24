import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stadium_project/gen/assets.gen.dart';
import 'package:stadium_project/src/feature/main/view_model/primary_vm.dart';

class PrimaryScreen extends ConsumerWidget {
  final Widget child;
  const PrimaryScreen(this.child, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(primaryVM);
    return Scaffold(
      body: child,
      bottomNavigationBar: SizedBox(
        height: 92.h,
        child: BottomNavigationBar(
          onTap: (index) {
            ref.read(primaryVM.notifier).changeNavigation(context, index);
          },
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: "Explore",
              icon: Assets.icons.exploreBottomNavigationBarIcon.svg(height: 20.h, width: 25.w, color: Colors.black),
              activeIcon: Assets.icons.exploreBottomNavigationBarIcon.svg(height: 20.h, width: 25.w),
            ),
            BottomNavigationBarItem(
              label: "Favourite",
              icon: Assets.icons.favouriteBottomNavigationBarIcon.svg(height: 24.h, width: 24.w),
              activeIcon:
                  Assets.icons.favouriteBottomNavigationBarIcon.svg(height: 24.h, width: 24.w, color: const Color.fromRGBO(42, 166, 76, 1)),
            ),
            BottomNavigationBarItem(
              label: "Account",
              icon: Assets.icons.accountBottomNavigationBarIcon.svg(height: 24.h, width: 24.w),
              activeIcon:
                  Assets.icons.accountBottomNavigationBarIcon.svg(height: 24.h, width: 24.w, color: const Color.fromRGBO(42, 166, 76, 1)),
            ),
          ],
        ),
      ),
    );
  }
}
