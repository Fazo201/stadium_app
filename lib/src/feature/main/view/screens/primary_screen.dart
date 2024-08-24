import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stadium_project/gen/assets.gen.dart';
import 'package:stadium_project/src/core/style/app_colors.dart';
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
          selectedLabelStyle: TextStyle(fontSize: 12.sp),
          selectedItemColor: AppColors.c2AA64C,
          unselectedItemColor: AppColors.c181725,
          backgroundColor: Colors.white,
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

  Widget _buildNavItem({
    required Widget icon,
    required Widget activeIcon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isActive ? activeIcon : icon,
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: isActive ? AppColors.c2AA64C : AppColors.c181725,
            ),
          ),
        ],
      ),
    );
  }
}
