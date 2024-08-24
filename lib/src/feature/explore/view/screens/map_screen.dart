import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:stadium_project/gen/assets.gen.dart';
import 'package:stadium_project/src/feature/explore/view/widgets/custom_explore_list_card_widget.dart';
import 'package:stadium_project/src/feature/explore/view_model/map_vm.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapState = ref.watch(mapVM);
    final mapVm = ref.read(mapVM.notifier);

    return Scaffold(
      body: Stack(
        children: [
          MaplibreMap(
            styleString: "https://api.maptiler.com/maps/streets/style.json?key=cNHdMMVZNCCvt2GJOiyf",
            initialCameraPosition: mapState.currentPosition != null
                ? CameraPosition(target: mapState.currentPosition!, zoom: 12)
                : const CameraPosition(target: LatLng(41.316441, 69.294861), zoom: 12),
            onMapCreated: (controller) {
              mapVm.setMapController(controller);
              controller.onSymbolTapped.add((symbol) {
                mapVm.onSymbolTapped(symbol.id);
              });
            },
          ),
          if (mapState.isSlideVisible && mapState.selectedStadium != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SlideTransition(
                position: mapVm.slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: CustomExploreListCardWidget(
                    stadiumModel: mapState.selectedStadium,
                    bookNowOnPressed: mapVm.closeSlideMessage,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: !mapState.isSlideVisible,
        child: FloatingActionButton(
          onPressed: () {
            mapVm.requestLocationPermission();
            mapVm.fetchStadiums();
          },
          backgroundColor: Colors.white,
          elevation: 0,
          shape: const CircleBorder(),
          child: Assets.icons.currentLocationIcon.svg(
            height: 24.h,
            width: 24.w,
          ),
        ),
      ),
    );
  }
}
