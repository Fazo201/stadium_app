import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stadium_project/gen/assets.gen.dart';
import 'package:stadium_project/src/core/constants/context_extension.dart';
import 'package:stadium_project/src/core/style/app_colors.dart';
import 'package:stadium_project/src/core/style/text_style.dart';
import 'package:stadium_project/src/data/model/stadium_model.dart';

class CustomExploreListCardWidget extends StatelessWidget {
  const CustomExploreListCardWidget({
    super.key,
    required this.stadiumModel,
    this.isAvailableOnPressed,
    this.bookNowOnPressed,
    this.locationOnPressed,
  });
  final StadiumModel? stadiumModel;
  final void Function()? isAvailableOnPressed;
  final void Function()? bookNowOnPressed;
  final void Function()? locationOnPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 168.h,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.theme.colorScheme.outline),
          color: context.theme.colorScheme.surfaceContainer
        ),
        child: Row(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                  width: 140.w,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(12),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(stadiumModel?.image ?? "https://i.ibb.co/khh3NYM/image.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                isAvailableOnPressed!=null? Positioned(
                  top: 10.h,
                  left: 10.w,
                  child: SizedBox(
                    height: 24.h,
                    width: 70.w,
                    child: ElevatedButton(
                      onPressed: isAvailableOnPressed,
                      style: ButtonStyle(
                        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                        backgroundColor: WidgetStatePropertyAll(
                          stadiumModel?.isAvailable??false ? const Color(0xff2AA64C) : const Color.fromRGBO(255, 218, 105, 1),
                        ),
                      ),
                      child: Text(stadiumModel?.isAvailable ==true ? "Working" : "Closed",style: TextStyle(color: stadiumModel?.isAvailable ==true?AppColors.white:AppColors.black),),
                    ),
                  ),
                ):const SizedBox(),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stadiumModel?.name??"",
                      style: const AppTextStyle().bodyLarge?.copyWith(color: AppColors.c181725,height: 1.1),
                    ),
                    Text(
                      stadiumModel?.address??"",
                      style: const AppTextStyle().bodyMedium?.copyWith(color: AppColors.cB2B2B2,height: 1, fontFamily: ""),
                    ),
                    Text(
                      stadiumModel?.pricePerHour.toString()??"",
                      style: const AppTextStyle().bodyLarge?.copyWith(color: AppColors.c2AA64C,height: 1,fontFamily: ""),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: bookNowOnPressed,
                            color: const Color(0xff2AA64C),
                            padding: EdgeInsets.zero,
                            elevation: 0,
                            height: 36.h,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide.none,
                            ),
                            child: Text("Book now!",style: const AppTextStyle().bodyMedium?.copyWith(color: AppColors.white)),
                          ),
                        ),
                        locationOnPressed!=null?MaterialButton(
                          onPressed: locationOnPressed,
                          color: const Color(0xffF7F7F7),
                          height: 36.h,
                          minWidth: 36.w,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none
                          ),
                          child: Assets.icons.exploreListNavigatorIcon.svg(height: 20.h, width: 25.w),
                        ): const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
