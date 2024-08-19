import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stadium_project/src/feature/explore/view/screens/list_screen.dart';
import 'package:stadium_project/src/feature/explore/view/screens/map_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          shadowColor: const Color(0x1F767680),
          elevation: 6,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: Container(
              height: 51.h,
              margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 17.h),
              padding: const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 3,),
              decoration: BoxDecoration(
                color: const Color(0x1F767680),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(7.r),
                  border: Border.all(width: 0.5.r,color: const Color.fromRGBO(0, 0, 0, 0.04)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.12),
                      offset: Offset(
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
                tabs: const [
                  Tab(
                    text: "context.localized.foodItems",
                  ),
                  Tab(
                    text: "context.localized.restaurants",
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            MapScreen(),
            ListScreen(),
          ],
        ),
      ),
    );
  }
}
