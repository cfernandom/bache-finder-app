import 'package:bache_finder_app/core/constants/enviroment.dart';
import 'package:bache_finder_app/core/constants/locations.dart';
import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:get/get.dart';

// Controlador GetX
class LocationPickerController extends GetxController {
  final Rx<LatLng?> _currentLatLng;
  final _isLoading = true.obs;

  LocationPickerController({LatLng? currentLatLng})
      : _currentLatLng = currentLatLng.obs;

  @override
  void onInit() async {
    super.onInit();
    if (_currentLatLng.value == null) {
      await _getCurrentLocation();
    }
    _isLoading.value = false;
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _setDefaultLocation();
      _showErrorSnackbar('Los servicios de ubicación están deshabilitados.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _setDefaultLocation();
        _showErrorSnackbar('Los permisos de ubicación están denegados.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _setDefaultLocation();
      _showErrorSnackbar(
          'Los permisos de ubicación están denegados permanentemente.');
      return;
    }

    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _currentLatLng.value =
        LatLng(currentPosition.latitude, currentPosition.longitude);
  }

  void _setDefaultLocation() {
    _currentLatLng.value = Locations.bogotaLatLng;
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Aviso',
      message,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      backgroundGradient: LinearGradient(
          colors: [Colors.orangeAccent[400]!, Colors.orange[200]!]),
      //backgroundColor: Colors.yellowAccent.withOpacity(0.8),
      colorText: Colors.black,
    );
  }
}

class LocationPickerScreen extends StatelessWidget {
  final void Function(LatLng?, String, String?) onChanged;
  final LatLng? currentLatLng;

  const LocationPickerScreen({
    super.key,
    required this.onChanged,
    required this.currentLatLng,
  });

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(LocationPickerController(currentLatLng: currentLatLng));

    return Obx(() {
      return controller._currentLatLng.value == null
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
              appBar: AppBar(
                title: const Text('Seleccionar Ubicación'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              body: _MapLocationPicker(
                currentLatLng: controller._currentLatLng.value,
                onChanged: onChanged,
              ),
            );
    });
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
      compassEnabled: true,
      popOnNextButtonTaped: true,
      minMaxZoomPreference: const MinMaxZoomPreference(12, 17),
      language: 'es',
      searchHintText: 'Buscar ubicación',
      placesBaseUrl: Enviroment.googleMapsApiProxyUrl(),
      geoCodingBaseUrl: Enviroment.googleMapsApiProxyUrl(),
      radius: 3000,
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
