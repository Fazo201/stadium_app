import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stadium_project/src/data/model/stadium_model.dart';
import 'package:stadium_project/src/data/repository/app_repository_impl.dart';
import 'package:stadium_project/src/feature/explore/view/widgets/custom_explore_list_card_widget.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  AppRepositoryImpl repositoryImpl = AppRepositoryImpl();
  List<StadiumModel?>? stadiumModel;

  Future<void> fetchData()async{
    stadiumModel = await repositoryImpl.getStadiumInfo();
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
          if (stadiumModel != null) {
            return CustomExploreListCardWidget(
              imageUrl: stadiumModel?[index]?.image ?? "https://i.ibb.co/khh3NYM/image.png",
              isAvailable: stadiumModel?[index]?.isAvailable ?? false,
              name: stadiumModel?[index]?.name ?? "",
              address: stadiumModel?[index]?.address?? "",
              pricePerHour: "${stadiumModel?[index]?.pricePerHour ?? "***"} uzs/hour",
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
        itemCount: stadiumModel?.length??5,
      ),
    );
  }
}
