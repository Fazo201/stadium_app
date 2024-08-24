import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stadium_project/src/feature/explore/view/widgets/custom_explore_list_card_widget.dart';
import 'package:stadium_project/src/feature/explore/view_model/list_vm.dart';

class ListScreen extends ConsumerWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stadiumsAsyncValue = ref.watch(stadiumsVm);

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: stadiumsAsyncValue.when(
        data: (stadiums) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            separatorBuilder: (BuildContext context, int index) {
              return 10.verticalSpace;
            },
            itemBuilder: (BuildContext context, int index) {
              return CustomExploreListCardWidget(
                stadiumModel: stadiums[index],
                isAvailableOnPressed: () {},
                bookNowOnPressed: () {},
                locationOnPressed: () {},
              );
            },
            itemCount: stadiums.length,
          );
        },
        loading: () {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            separatorBuilder: (BuildContext context, int index) {
              return 10.verticalSpace;
            },
            itemBuilder: (BuildContext context, int index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade200,
                period: const Duration(milliseconds: 800),
                child: SizedBox(
                  height: 168.h,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
            itemCount: 5,
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text('Error: $error'));
        },
      ),
    );
  }
}
