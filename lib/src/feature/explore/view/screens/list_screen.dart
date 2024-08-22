import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stadium_project/src/core/server/api/api_server.dart';
import 'package:stadium_project/src/data/model/stadium_model.dart';
import 'package:stadium_project/src/feature/explore/view/widgets/custom_explore_list_card_widget.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  ApiServer apiServer = ApiServer(Dio());
  List<StadiumModel?>? stadiums;

  Future<void> fetchData()async{
    stadiums = await apiServer.getStadiumInfo();
    setState(() {});
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: ListView.separated(
        padding: EdgeInsets.only(top: 25.h, left: 25.w, right: 25.w),
        separatorBuilder: (BuildContext context, int index) {
          return 10.verticalSpace;
        },
        itemBuilder: (BuildContext context, int index) {
          if (stadiums != null) {
            return CustomExploreListCardWidget(
              imageUrl: stadiums?[index]?.image ?? "https://i.ibb.co/khh3NYM/image.png",
              isAvailable: stadiums?[index]?.isAvailable ?? false,
              name: stadiums?[index]?.name ?? "",
              address: stadiums?[index]?.address?? "",
              pricePerHour: "${stadiums?[index]?.pricePerHour ?? "***"} uzs/hour",
              isAvailableOnPressed: () {},
              bookNowOnPressed: () {},
              locationOnPressed: () {},
            );
          } else {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade200,
              period: const Duration(milliseconds: 800),
              child: SizedBox(
                height: 168.h,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
                ),
              ),
            );
          }
        },
        itemCount: stadiums?.length??5,
      ),
    );
  }
}
