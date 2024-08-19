import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stadium_project/gen/assets.gen.dart';

class CustomExploreListCardWidget extends StatelessWidget {
  const CustomExploreListCardWidget({
    super.key,
    required this.isAvailable,
  });
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 168.h,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Image.network("https://i.ibb.co/3RSgDTN/image.png"),
                SizedBox(
                  height: 24.h,
                  width: 70.w,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                      backgroundColor: WidgetStatePropertyAll(
                        isAvailable ? const Color(0xff2AA64C) : const Color.fromRGBO(255, 218, 105, 1),
                      ),
                    ),
                    child: Text(isAvailable ? "Working" : "Closed"),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Text("Stadium “Signal Iduna Park"),
                const Text("Shayhontohur, St. Bunyodkor"),
                const Text("120 000 uzs/hour"),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      color: const Color(0xff2AA64C),
                      child: Text("Book now!"),
                    ),
                    Assets.icons.exploreListNavigatorIcon.svg(height: 20.h, width: 25.w)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
