import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stadium_project/gen/assets.gen.dart';
import 'package:stadium_project/src/core/constants/context_extension.dart';
import 'package:stadium_project/src/core/style/app_colors.dart';
import 'package:stadium_project/src/core/style/text_style.dart';
import 'package:stadium_project/src/data/entity/stadium_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomExploreListCardWidget extends StatelessWidget {
  const CustomExploreListCardWidget({
    super.key,
    required this.stadiumModel,
    this.workingHoursPressed,
    this.callOnPressed,
    this.locationOnPressed,
  });
  final StadiumModel? stadiumModel;
  final void Function()? workingHoursPressed;
  final void Function()? callOnPressed;
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
            color: context.theme.colorScheme.surfaceContainer),
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
                        image:
                            NetworkImage(stadiumModel?.image ?? "https://i.pinimg.com/736x/39/f5/53/39f553e517577a7bc00138b93a6d176d.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                if (workingHoursPressed != null && stadiumModel?.workingHours != null)
                  Positioned(
                    top: 10.h,
                    left: 10.w,
                    child: SizedBox(
                      height: 24.h,
                      width: 70.w,
                      child: ElevatedButton(
                        onPressed: workingHoursPressed,
                        style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero),
                          backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 237, 235, 78)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: FittedBox(
                            child: Text(
                              stadiumModel!.workingHours!,
                              style: const TextStyle(
                                color: AppColors.c181725,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  const SizedBox(),
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
                      stadiumModel?.name ?? "",
                      style: const AppTextStyle().bodyLarge?.copyWith(color: context.theme.colorScheme.onSecondaryContainer, height: 1.1),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      stadiumModel?.address ?? "",
                      style: const AppTextStyle().bodyMedium?.copyWith(color: AppColors.cB2B2B2, height: 1, fontFamily: ""),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      stadiumModel?.pricePerHour != null ? stadiumModel!.pricePerHour! : "",
                      style: const AppTextStyle().bodyMedium?.copyWith(color: AppColors.c2AA64C, height: 1, fontFamily: "Gilroy"),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: () async {
                              if (stadiumModel?.phoneNumber != null) {
                                final Uri url = Uri(scheme: 'tel', path: stadiumModel!.phoneNumber);
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                } else {
                                  log('launchUrl error: $url');
                                }
                              }
                            },
                            color: const Color(0xff2AA64C),
                            padding: EdgeInsets.zero,
                            elevation: 0,
                            height: 36.h,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide.none,
                            ),
                            child: Text("Qo'ng'iroq", style: const AppTextStyle().bodyMedium?.copyWith(color: AppColors.white)),
                          ),
                        ),
                        locationOnPressed != null
                            ? MaterialButton(
                                onPressed: locationOnPressed,
                                color: const Color(0xffF7F7F7),
                                height: 36.h,
                                minWidth: 36.w,
                                elevation: 0,
                                padding: EdgeInsets.zero,
                                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
                                child: Assets.icons.exploreListNavigatorIcon.svg(height: 20.h, width: 25.w),
                              )
                            : const SizedBox(),
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
