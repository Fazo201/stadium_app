import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stadium_project/gen/assets.gen.dart';
import 'package:stadium_project/src/data/entity/stadium_model.dart';
import 'package:stadium_project/src/data/repository/app_repository_impl.dart';
import 'package:stadium_project/src/feature/home/view/widgets/custom_current_location_icon_painter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mapProvider = ChangeNotifierProvider<MapVm>((ref) {
  return MapVm();
});


class MapVm extends ChangeNotifier {
  MapLibreMapController? _mapController;
  LatLng? _currentPosition;
  Symbol? _currentLocationSymbolId;
  StreamSubscription<Position>? _positionStreamSubscription;

  final AppRepositoryImpl _appRepositoryImpl = AppRepositoryImpl();
  List<StadiumModel?>? _stadiums;
  final Map<String, StadiumModel> symbolStadiumMap = {};
  AnimationController? _animationController;
  Animation<Offset>? _slideAnimation;
  bool _isSlideVisible = false;
  StadiumModel? _selectedStadium;

  MapVm() {
    _requestLocationPermission();

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      currentLocation(position);
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  void setMapController(MapLibreMapController controller) {
    log("setMapController");
    _mapController = controller;
  }

  Future<void> showCurrentLocation({double? zoom}) async {
    log("showCurrentLocation");
    if (_mapController == null) return;
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
        ),
      );
      _currentPosition = LatLng(position.latitude, position.longitude);
      if (_currentLocationSymbolId != null && _mapController!.symbols.contains(_currentLocationSymbolId)) {
        _mapController?.updateSymbol(
          _currentLocationSymbolId!,
          SymbolOptions(
            geometry: _currentPosition,
          ),
        );
      } else {
        Uint8List imageBytes = await _createIcon();
        _mapController?.addImage('current_location_icon', imageBytes);
        _currentLocationSymbolId = await _mapController?.addSymbol(
          SymbolOptions(
            geometry: _currentPosition,
            iconImage: 'current_location_icon',
            iconSize: 1,
          ),
        );
      }
      if (zoom != null) {
        _mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: zoom,
            ),
          ),
        );
      }
    } catch (e) {
      log("Error: $e");
    }
  }

  Future<void> _requestLocationPermission() async {
    log("_requestLocationPermission");
    try {
      var status = await Permission.location.request();
      if (status.isGranted) {
        // await showCurrentLocation(zoom: 12);
      } else {
        log("Permission denied");
      }
    } catch (e) {
      log("Request location permission error: $e");
    }
  }

  Future<void> currentLocation(Position position) async {
    log("currentLocation");
    _currentPosition = LatLng(position.latitude, position.longitude);
    if (_mapController != null) {
      if (_currentLocationSymbolId != null && _mapController!.symbols.contains(_currentLocationSymbolId)) {
        _mapController?.updateSymbol(
          _currentLocationSymbolId!,
          SymbolOptions(
            geometry: LatLng(position.latitude, position.longitude),
          ),
        );
      } else {
        Uint8List imageBytes = await _createIcon();
        _mapController?.addImage('current_location_icon', imageBytes);
        _currentLocationSymbolId = await _mapController?.addSymbol(
          SymbolOptions(
            geometry: LatLng(position.latitude, position.longitude),
            iconImage: 'current_location_icon',
            iconSize: 1,
          ),
        );
      }
    }
  }

  Future<Uint8List> _createIcon() async {
    log("_createIcon");
    final PictureRecorder recorder = PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    const double size = 64.0;

    final CurrentLocationIcon painter = CurrentLocationIcon();
    painter.paint(canvas, const Size(size, size));

    final img = await recorder.endRecording().toImage(size.toInt(), size.toInt());
    final ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<void> fetchStadiums() async {
    log("fetchStadiums");
    try {
      _stadiums = await _appRepositoryImpl.getStadiumsFirebase();
      if (_mapController != null && _stadiums != null) {
        for (var stadium in _stadiums!) {
          if (stadium != null && stadium.longitude != null && stadium.latitude != null) {
            final symbolId = await _mapController!.addSymbol(
              SymbolOptions(
                geometry: LatLng(stadium.latitude!, stadium.longitude!),
                iconImage: Assets.images.mapPointStadiumIcon.path,
                iconSize: 1.2,
              ),
            );

            symbolStadiumMap[symbolId.id] = stadium;
          }
        }
        notifyListeners();
      }
    } catch (e) {
      log("Error fetching stadium data: $e");
    }
  }

  // Slide
  void initializeAnimations(TickerProvider tickerProvider) {
    log("initializeAnimations");

    if (_animationController != null) {
      return; 
    }
    _animationController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );
  }

  void showSlideMessage(StadiumModel stadium) {
    log("showSlideMessage");
    _selectedStadium = stadium;
    _isSlideVisible = true;
    _animationController?.forward();
    notifyListeners();
  }

  void closeSlideMessage() {
    log("closeSlideMessage");
    _animationController?.reverse().then((_) {
      _isSlideVisible = false;
      _selectedStadium = null;
      notifyListeners();
    });
  }

  bool get isSlideVisible => _isSlideVisible;
  Animation<Offset>? get slideAnimation => _slideAnimation;
  StadiumModel? get selectedStadium => _selectedStadium;
  LatLng? get currentPosition => _currentPosition;
}
