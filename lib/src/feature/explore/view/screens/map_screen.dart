import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stadium_project/gen/assets.gen.dart';
import 'package:stadium_project/src/core/server/api/api_server.dart';
import 'package:stadium_project/src/data/model/stadium_model.dart';
import 'package:stadium_project/src/feature/explore/view/widgets/custom_explore_list_card_widget.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  MaplibreMapController? _mapController;
  LatLng? _currentPosition;
  Symbol? _currentLocationSymbolId;

  ApiServer apiServer = ApiServer(Dio());
  List<StadiumModel?>? stadiums;

  final Map<String, StadiumModel> _symbolStadiumMap = {};
  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;
  bool _isSlideVisible = false;
  StadiumModel? _selectedStadium;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _requestLocationPermission();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
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

  Future<void> _fetchStadiums() async {
    log("Fetching stadiums");
    try {
      stadiums = await apiServer.getStadiumInfo();

      if (_mapController != null && stadiums != null) {
        for (var stadium in stadiums!) {
          if (stadium != null && stadium.longitude != null && stadium.latitude != null) {
            final symbolId = await _mapController!.addSymbol(
              SymbolOptions(
                geometry: LatLng(stadium.longitude!, stadium.latitude!),
                iconImage: Assets.images.mapPointStadiumIcon.path,
                iconSize: 2.5,
                textOffset: const Offset(0, 1.5),
              ),
            );

            _symbolStadiumMap[symbolId.id] = stadium;
            log("Added symbol with ID: ${symbolId.id}");
          }
        }
      }
      setState(() {});
    } catch (e) {
      log("Error fetching stadium data: $e");
    }
  }

  Future<void> _requestLocationPermission() async {
    log("Requesting location permission");
    var status = await Permission.location.request();

    if (status.isGranted) {
      log("Permission granted");
      if (mounted) {
        _showCurrentLocation();
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location services are disabled.'),
          ),
        );
      }
    }
  }

  Future<void> _showCurrentLocation() async {
    log("_showCurrentLocation");
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 0,
        ),
      );

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
          log("Map controller is not initialized");
        }
      }
    } catch (e) {
      log("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to get current location.'),
        ),
      );
    }
  }

  Future<Uint8List> _loadAssetImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  void _showSlideMessage(StadiumModel stadium) {
    setState(() {
      _selectedStadium = stadium;
      _isSlideVisible = true;
    });
    _animationController.forward();
  }

  void _closeSlideMessage() {
    _animationController.reverse().then((_) {
      if (mounted) {
        setState(() {
          _isSlideVisible = false;
          _selectedStadium = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MaplibreMap(
            styleString: "https://api.maptiler.com/maps/streets/style.json?key=cNHdMMVZNCCvt2GJOiyf",
            initialCameraPosition: _currentPosition != null
                ? CameraPosition(target: _currentPosition!, zoom: 12)
                : const CameraPosition(target: LatLng(41.316441, 69.294861), zoom: 12),
            onMapCreated: (controller) {
              _mapController = controller;
              _fetchStadiums();
              _mapController!.onSymbolTapped.add((symbol) {
                if (_symbolStadiumMap.containsKey(symbol.id)) {
                  _showSlideMessage(_symbolStadiumMap[symbol.id]!);
                }
              });
            },
          ),
          if (_isSlideVisible && _selectedStadium != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: CustomExploreListCardWidget(
                    stadiumModel: _selectedStadium,
                    bookNowOnPressed: _closeSlideMessage,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: !_isSlideVisible,
        child: FloatingActionButton(
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
          ),
        ),
      ),
    );
  }
}
