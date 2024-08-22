import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:maplibre_gl_platform_interface/maplibre_gl_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:stadium_project/gen/assets.gen.dart';
import 'package:stadium_project/src/core/server/api/api_server.dart';
import 'package:stadium_project/src/data/model/stadium_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MaplibreMapController? _mapController;
  bool _isLocationEnabled = true;
  LatLng? _currentPosition;
  Symbol? _currentLocationSymbolId;
  double _deviceDirection = 0.0;
  StreamSubscription<CompassEvent>? _compassSubscription;

  ApiServer apiServer = ApiServer(Dio());
  List<StadiumModel?>? stadiums;

  Symbol? idLocations;
  final Map<String, StadiumModel> symbolStadiumMap = {};

  Future<void> _fetchStadiums() async {
    log("_fetchStadiums");
    try {
      stadiums = await apiServer.getStadiumInfo();

      if (_mapController != null && stadiums != null) {
        for (var stadium in stadiums!) {
          if (stadium != null && stadium.longitude != null && stadium.latitude != null) {
            idLocations = await _mapController!.addSymbol(
              SymbolOptions(
                geometry: LatLng(stadium.longitude!, stadium.latitude!),
                iconImage: Assets.images.mapPointStadiumIcon.path,
                iconSize: 2.5,
                textOffset: const Offset(0, 1.5),
              ),
            );

            symbolStadiumMap[idLocations!.id] = stadium;
            log("idLocations: ${idLocations!.id}");
          }
        }
      }
      symbolStadiumMap.keys.forEach((key) {
        log("forEAch: $key"); 
      });
      setState(() {});
    } catch (e) {
      log("Stadion ma'lumotlarini olishda xatolik: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    // _requestLocationPermission();
    // _listenToCompass();
  }

  @override
  void dispose() {
    _compassSubscription?.cancel();
    super.dispose();
  }

  Future<void> _requestLocationPermission() async {
    log("Запрашивается разрешение на геолокацию");
    var status = await Permission.location.request();

    if (status.isGranted) {
      log("Разрешение предоставлено");
      if (mounted) {
        _showCurrentLocation();
      }
    } else {
      log("Разрешение не предоставлено");
      if (mounted) {
        setState(() {
          _isLocationEnabled = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Геолокация отключена. Пожалуйста, включите её.'),
          ),
        );
      }
    }
  }

  void _listenToCompass() {
    _compassSubscription = FlutterCompass.events!.listen((CompassEvent event) {
      if (mounted) {
        setState(() {
          _deviceDirection = event.heading ?? 0.0;
        });

        if (_currentLocationSymbolId != null && _mapController != null) {
          _mapController!.updateSymbol(
            _currentLocationSymbolId!,
            SymbolOptions(
              iconRotate: _deviceDirection,
            ),
          );
        }
      }
    });
  }

  Future<void> _showCurrentLocation() async {
    log("_showCurrentLocation");
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      log("Текущее местоположение: ${position.latitude}, ${position.longitude}");

      if (mounted) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
        });

        if (_mapController != null) {
          final imageBytes = await _loadAssetImage(Assets.images.currentLocationNavigatorIcon.path);

          if (_currentLocationSymbolId != null) {
            _mapController!.updateSymbol(
              _currentLocationSymbolId!,
              SymbolOptions(
                geometry: LatLng(position.latitude, position.longitude),
              ),
            );
          } else {
            _mapController!.addImage(
              'current_location_icon',
              imageBytes,
            );

            _currentLocationSymbolId = await _mapController!.addSymbol(
              SymbolOptions(
                geometry: LatLng(position.latitude, position.longitude),
                iconImage: 'current_location_icon',
                iconRotate: _deviceDirection,
                iconSize: 0.15,
              ),
            );
          }

          _mapController!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 12,
              ),
            ),
          );
        } else {
          log("Контроллер карты не установлен");
        }
      }
    } catch (e) {
      log("Ошибка: $e");
      if (mounted) {
        setState(() {
          _isLocationEnabled = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Не удалось получить местоположение.'),
          ),
        );
      }
    }
  }

  Future<Uint8List> _loadAssetImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaplibreMap(
        styleString: "https://api.maptiler.com/maps/streets/style.json?key=cNHdMMVZNCCvt2GJOiyf",
        initialCameraPosition: _currentPosition != null
            ? CameraPosition(
                target: _currentPosition!,
                zoom: 12,
              )
            : const CameraPosition(
                target: LatLng(41.316441, 69.294861),
                zoom: 12,
              ),
        onMapCreated: (MaplibreMapController controller) {
          if (mounted) {
            // setState(() {
              _mapController = controller;

              // if (_isLocationEnabled) {
              //   _showCurrentLocation();
              // }
              _fetchStadiums();
            // });
          }
          _mapController!.onSymbolTapped.add((symbol) {
            log(symbol.id);
            log(symbolStadiumMap.containsKey(symbol.id).toString());
            if (symbolStadiumMap.containsKey(symbol.id)) {
              final stadium = symbolStadiumMap[symbol.id];
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Name: ${stadium?.name}\nAddress: ${stadium?.address}\nPrice: ${stadium?.pricePerHour} uzs/hour',
                  ),
                ),
              );
            }
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mounted) {
            _requestLocationPermission();
          }
        },
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const CircleBorder(
          side: BorderSide(
            color: Color.fromRGBO(237, 237, 237, 1),
          ),
        ),
        child: Assets.icons.currentLocationIcon.svg(
          height: 24.h,
          width: 24.w,
          color: _isLocationEnabled ? Colors.black : Colors.red,
        ),
      ),
    );
  }
}
