import 'package:bache_finder_app/core/constants/enviroment.dart';
import 'package:bache_finder_app/core/constants/locations.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    required void Function(LatLng? latLng, String address, String? locality) onLocationChangedCallback,
  })  : _onLocationChangedCallback = onLocationChangedCallback,
        _currentLatLng = currentLatLng.obs;

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

    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _currentLatLng.value =
        LatLng(currentPosition.latitude, currentPosition.longitude);
  }

  void _setDefaultLocation() {
    _currentLatLng.value = Locations.bogotaLatLng;
  }

  void onLocationChanged() {
    _onLocationChangedCallback(_currentLatLng.value, _address.value, _locality.value);
  }
}

class LocationPickerScreen extends GetView<LocationPickerController> {
  const LocationPickerScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) return;
        context.pop();
      },
      child: Obx(() {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (controller._warningMessage.value != '' &&
              controller._isLoading.value == false) {
            SnackbarWidget.showSnackbar(context,
                message: controller._warningMessage.value);
            controller._warningMessage.value = '';
          }
        });
        return controller._currentLatLng.value == null
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                appBar: AppBar(
                  title: const Text('Seleccionar Ubicación'),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ),
                body: _MapLocationPicker(
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
