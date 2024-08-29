import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stadium_project/gen/assets.gen.dart';
import 'package:stadium_project/src/core/constants/context_extension.dart';
import 'package:stadium_project/src/core/style/text_style.dart';
import 'package:stadium_project/src/feature/home/view/screens/list_screen.dart';
import 'package:stadium_project/src/feature/home/view/screens/map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: context.theme.colorScheme.shadow,
        elevation: 6,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: Container(
            height: 51.h,
            margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 17.h),
            padding: const EdgeInsets.only(
              left: 2,
              right: 2,
              top: 2,
              bottom: 3,
            ),
            decoration: BoxDecoration(
              color: context.theme.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: AnimatedBuilder(
              animation: _tabController,
              builder: (context,_) {
                return TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: context.theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(7.r),
                    border: Border.all(width: 0.5.r, color: context.theme.colorScheme.outline),
                    boxShadow: [
                      BoxShadow(
                        color: context.theme.colorScheme.outline,
                        offset: const Offset(
                          0.0,
                          1.0,
                        ),
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                  dividerHeight: 0,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: const Color(0xff2AA64C),
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _tabController.index == 0
                              ? Assets.icons.exploreTabBarMapSelectedIcon.svg(height: 16.h, width: 16.w)
                              : Assets.icons.exploreTabBarMapIcon.svg(height: 16.h, width: 16.w),
                          6.horizontalSpace,
                          Text(
                            "Xarita",
                            style: const AppTextStyle().bodyLarge?.copyWith(fontFamily: ""),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _tabController.index == 1
                              ? Assets.icons.exploreTabBarListSelectedIcon.svg(height: 16.h, width: 16.w)
                              : Assets.icons.exploreTabBarListIcon.svg(height: 16.h, width: 16.w),
                          6.horizontalSpace,
                          Text(
                            "Ro'yxat",
                            style: const AppTextStyle().bodyLarge?.copyWith(fontFamily: ""),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          MapScreen(),
          ListScreen(),
        ],
      ),
    );
  }
}
