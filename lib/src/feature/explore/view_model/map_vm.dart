import 'dart:developer';

import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stadium_project/gen/assets.gen.dart';
import 'package:stadium_project/src/core/server/api/api_server.dart';
import 'package:stadium_project/src/data/model/stadium_model.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:flutter/services.dart';
import 'package:stadium_project/src/feature/explore/view_model/list_vm.dart';


final mapVM = StateNotifierProvider<MapVm, MapState>((ref) {
  final apiServer = ref.watch(apiServerVm);
  return MapVm(apiServer);
});

class MapVm extends StateNotifier<MapState> {
  MapVm(this._apiServer) : super(MapState()) {
    fetchStadiums();
    requestLocationPermission();
    _initAnimationController();
  }

  final ApiServer _apiServer;
  MaplibreMapController? _mapController;
  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;

  void _initAnimationController() {
    _animationController = AnimationController(
      vsync: _AnimationTickerProvider(),
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  Future<void> fetchStadiums() async {
    try {
      final stadiums = await _apiServer.getStadiumInfo();
      if (_mapController != null) {
        for (var stadium in stadiums) {
          if (stadium.longitude != null && stadium.latitude != null) {
            final symbolId = await _mapController!.addSymbol(
              SymbolOptions(
                geometry: LatLng(stadium.longitude!, stadium.latitude!),
                iconImage: Assets.images.mapPointStadiumIcon.path,
                iconSize: 2.5,
                textOffset: const Offset(0, 1.5),
              ),
            );
            state = state.copyWith(symbolStadiumMap: {...state.symbolStadiumMap, symbolId.id: stadium});
          }
        }
      }
    } catch (e) {
      log("Error fetching stadium data: $e");
    }
  }

  Future<void> requestLocationPermission() async {
    final permission = await Permission.location.request();
    if (permission.isGranted) {
      await _showCurrentLocation();
    }
  }

  Future<void> _showCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 0,
        ),
      );

      if (_mapController != null) {
        final imageBytes = await _loadAssetImage(Assets.images.currentLocationNavigatorIcon.path);

        await _mapController!.addImage('current_location_icon', imageBytes);

        final symbolId = await _mapController!.addSymbol(
          SymbolOptions(
            geometry: LatLng(position.latitude, position.longitude),
            iconImage: 'current_location_icon',
            iconSize: 0.15,
          ),
        );

        state = state.copyWith(
          currentPosition: LatLng(position.latitude, position.longitude),
          currentLocationSymbolId: symbolId,
        );

        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 12,
            ),
          ),
        );
      }
    } catch (e) {
      log("Map controller is not initialized");
    }
  }

  Future<Uint8List> _loadAssetImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  void setMapController(MaplibreMapController controller) {
    _mapController = controller;
  }

  void onSymbolTapped(String symbolId) {
    final stadium = state.symbolStadiumMap[symbolId];
    if (stadium != null) {
      state = state.copyWith(selectedStadium: stadium, isSlideVisible: true);
      _animationController.forward();
    }
  }

  void closeSlideMessage() {
    _animationController.reverse().then((_) {
      state = state.copyWith(selectedStadium: null, isSlideVisible: false);
    });
  }

  Animation<Offset> get slideAnimation => _slideAnimation;
}

class MapState {
  final LatLng? currentPosition;
  final Symbol? currentLocationSymbolId;
  final Map<String, StadiumModel> symbolStadiumMap;
  final StadiumModel? selectedStadium;
  final bool isSlideVisible;

  MapState({
    this.currentPosition,
    this.currentLocationSymbolId,
    this.symbolStadiumMap = const {},
    this.selectedStadium,
    this.isSlideVisible = false,
  });

  MapState copyWith({
    LatLng? currentPosition,
    Symbol? currentLocationSymbolId,
    Map<String, StadiumModel>? symbolStadiumMap,
    StadiumModel? selectedStadium,
    bool? isSlideVisible,
  }) {
    return MapState(
      currentPosition: currentPosition ?? this.currentPosition,
      currentLocationSymbolId: currentLocationSymbolId ?? this.currentLocationSymbolId,
      symbolStadiumMap: symbolStadiumMap ?? this.symbolStadiumMap,
      selectedStadium: selectedStadium ?? this.selectedStadium,
      isSlideVisible: isSlideVisible ?? this.isSlideVisible,
    );
  }
}



class _AnimationTickerProvider extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

