import 'package:bache_finder_app/core/constants/enviroment.dart';
import 'package:bache_finder_app/core/constants/locations.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/gap_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:get/get.dart';

class LocationPickerController extends GetxController {
  final void Function(LatLng? latLng, String address, String? locality)
      _onLocationChangedCallback;
  final Rx<LatLng?> _currentLatLng;
  final Rx<String> _address = ''.obs;
  final Rx<String?> _locality = ''.obs;
  final _isLoading = true.obs;
  final _warningMessage = ''.obs;

  LocationPickerController({
    LatLng? currentLatLng,
    required void Function(LatLng? latLng, String address, String? locality)
        onLocationChangedCallback,
  })  : _onLocationChangedCallback = onLocationChangedCallback,
        _currentLatLng = currentLatLng.obs;

  @override
  void onInit() async {
    super.onInit();
    _initializeMapRenderer();
    if (_currentLatLng.value == null) {
      await _getCurrentLocation();
    }
    _isLoading.value = false;
  }

  void _initializeMapRenderer() {
    // https://stackoverflow.com/questions/78514657/google-maps-flutter-issues-updateacquirefence-did-not-find-frame-expecting
    final GoogleMapsFlutterPlatform mapsImplementation =
        GoogleMapsFlutterPlatform.instance;
    if (mapsImplementation is GoogleMapsFlutterAndroid) {
      mapsImplementation.useAndroidViewSurface = true;
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _setDefaultLocation();
      _warningMessage.value =
          'Los servicios de ubicación están deshabilitados.';
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _setDefaultLocation();
        _warningMessage.value = 'Los permisos de ubicación están denegados.';
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _setDefaultLocation();
      _warningMessage.value =
          'Los permisos de ubicación están denegados permanentemente.';
      return;
    }

    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 1,
    );

    Position currentPosition =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    _currentLatLng.value =
        LatLng(currentPosition.latitude, currentPosition.longitude);
  }

  void _setDefaultLocation() {
    _currentLatLng.value = Locations.bogotaLatLng;
  }

  void onLocationChanged() {
    _onLocationChangedCallback(
        _currentLatLng.value, _address.value, _locality.value);
  }
}

class LocationPickerScreen extends GetView<LocationPickerController> {
  const LocationPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context.pop();
        }
      },
      child: Obx(() {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (controller._warningMessage.value != '' &&
              controller._isLoading.value == false) {
            SnackbarWidget.show(context,
                message: controller._warningMessage.value);
            controller._warningMessage.value = '';
          }
        });
        return Scaffold(
          appBar: AppBar(
            title: const Text('Seleccionar Ubicación'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.pop();
              },
            ),
          ),
          body: controller._currentLatLng.value == null
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      GapWidget(size: 16.0),
                      Text('Cargando ubicación cercana...'),
                    ],
                  ),
                )
              : _MapLocationPicker(
                  currentLatLng: controller._currentLatLng.value,
                  onChanged: controller._onLocationChangedCallback,
                ),
        );
      }),
    );
  }
}

class _MapLocationPicker extends StatelessWidget {
  const _MapLocationPicker({
    required this.currentLatLng,
    required this.onChanged,
  });

  final LatLng? currentLatLng;
  final void Function(LatLng? currentLatLng, String address, String? locality)
      onChanged;

  @override
  Widget build(BuildContext context) {
    return MapLocationPicker(
      apiKey: '',
      currentLatLng: currentLatLng,
      hideMoreOptions: true,
      hideMapTypeButton: true,
      hideBackButton: true,
      compassEnabled: false,
      rotateGesturesEnabled: false,
      popOnNextButtonTaped: true,
      minMaxZoomPreference: const MinMaxZoomPreference(12, 19),
      language: 'es',
      searchHintText: 'Buscar ubicación',
      placesBaseUrl: Enviroment.googleMapsApiProxyUrl(),
      geoCodingBaseUrl: Enviroment.googleMapsApiProxyUrl(),
      trafficEnabled: false,
      buildingsEnabled: false,
      onNext: (GeocodingResult? result) {
        if (result != null) {
          final address = result.formattedAddress ?? '';
          final lat = result.geometry.location.lat;
          final lng = result.geometry.location.lng;

          String? locality;
          for (var component in result.addressComponents) {
            if (component.types.contains('sublocality')) {
              locality = component.longName;
              break;
            }
          }
          onChanged(LatLng(lat, lng), address, locality);
        }
      },
    );
  }
}
