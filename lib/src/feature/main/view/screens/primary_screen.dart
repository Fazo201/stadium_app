import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:stadium_project/gen/assets.gen.dart";
import "package:stadium_project/src/core/style/app_colors.dart";
import "package:stadium_project/src/feature/main/view_model/primary_vm.dart";

class PrimaryScreen extends ConsumerWidget {
  final Widget child;
  const PrimaryScreen(this.child, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        body: child,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            ref.read(primaryVM).changeNavigation(context, index);
          },
          selectedLabelStyle: TextStyle(fontSize: 12.sp),
          selectedItemColor: AppColors.c2AA64C,
          unselectedItemColor: AppColors.c181725,
          backgroundColor: Colors.white,
          currentIndex: ref.watch(primaryVM).currentIndex,
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
      );
}
