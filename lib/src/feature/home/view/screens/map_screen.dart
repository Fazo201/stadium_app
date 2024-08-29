import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:stadium_project/gen/assets.gen.dart';
import 'package:stadium_project/src/core/constants/context_extension.dart';
import 'package:stadium_project/src/core/widgets/app_material_context.dart';
import 'package:stadium_project/src/feature/home/view/widgets/custom_explore_list_card_widget.dart';
import 'package:stadium_project/src/feature/home/view_model/map_vm.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    ref.read(mapProvider.notifier).initializeAnimations(this);
  }

  @override
  Widget build(BuildContext context) {
    final mapVm = ref.watch(mapProvider);
    return Scaffold(
      body: Stack(
        children: [
          MapLibreMap(
            styleString: themeController.isLight
                ? "https://api.maptiler.com/maps/streets-v2-light/style.json?key=cNHdMMVZNCCvt2GJOiyf"
                : "https://api.maptiler.com/maps/streets-v2-dark/style.json?key=cNHdMMVZNCCvt2GJOiyf",
            initialCameraPosition: mapVm.currentPosition != null
                ? CameraPosition(target: mapVm.currentPosition!, zoom: 12)
                : const CameraPosition(target: LatLng(41.316441, 69.294861), zoom: 10),
            onMapCreated: (controller) {
              log("onMapCreated");
              mapVm.setMapController(controller);
              controller.onSymbolTapped.add((symbol) {
                if (mapVm.symbolStadiumMap.containsKey(symbol.id)) {
                  mapVm.showSlideMessage(mapVm.symbolStadiumMap[symbol.id]!);
                }
              });
            },
            onStyleLoadedCallback: () {
              log("onStyleLoadedCallback");
              mapVm.fetchStadiums();
              mapVm.showCurrentLocation();
            },
            onMapClick: (point, coordinates) {
              if (mapVm.isSlideVisible) {
                mapVm.closeSlideMessage();
              }
            },
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                themeController.switchTheme();
              },
              icon: Icon(
                themeController.isLight ? Icons.dark_mode : Icons.light_mode,
                color: context.theme.colorScheme.onSurface,
              ),
            ),
          ),
          if (mapVm.isSlideVisible && mapVm.selectedStadium != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SlideTransition(
                position: mapVm.slideAnimation!,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: CustomExploreListCardWidget(
                    stadiumModel: mapVm.selectedStadium,
                    workingHoursPressed: () {},
                    // locationOnPressed: () {},
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: !mapVm.isSlideVisible,
        child: FloatingActionButton(
          onPressed: () async {
            await mapVm.showCurrentLocation(zoom: 18);
          },
          backgroundColor: context.theme.colorScheme.surface,
          elevation: 3,
          shape: const CircleBorder(
            side: BorderSide(
              color: Color.fromRGBO(237, 237, 237, 1),
            ),
          ),
          child: Assets.icons.currentLocationIcon.svg(
            height: 24.h,
            width: 24.w,
            // ignore: deprecated_member_use_from_same_package
            color: themeController.isDark ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}
