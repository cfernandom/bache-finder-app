import 'package:bache_finder_app/features/pothole/domain/entities/pothole.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/image_input.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/latitude_input.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/locality_input.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/longitude_input.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/text_input.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_location_picker/map_location_picker.dart';

class PotholeFormController extends GetxController {
  final Future<bool> Function(Map<String, dynamic> potholeLike)
      _onSubmitCallback;

  final Rx<TextInput> _address;
  final Rx<TextInput> _description;
  final Rx<ImageInput> _image;
  final Rx<LatitudeInput> _latitude;
  final Rx<LongitudeInput> _longitude;
  final Rx<LocalityInput> _locality;

  PotholeFormController(
    Pothole? pothole, {
    required onSubmitCallback,
  })  : _onSubmitCallback = onSubmitCallback,
        _address = TextInput.pure(pothole?.address ?? '').obs,
        _description = TextInput.pure(pothole?.description ?? '').obs,
        _image = ImageInput.pure(XFile(pothole?.image ?? '')).obs,
        _latitude = LatitudeInput.pure(pothole?.latitude.toString() ?? '').obs,
        _longitude =
            LongitudeInput.pure(pothole?.longitude.toString() ?? '').obs,
        _locality = LocalityInput.pure(pothole?.locality).obs;

  final _isPosted = false.obs;
  final _isPosting = false.obs;
  final _isValid = false.obs;
  final _isModifed = false.obs;

  bool get isPosted => _isPosted.value;
  bool get isPosting => _isPosting.value;
  bool get isModifed => _isModifed.value;
  Rx<ImageInput> get image => _image;
  Rx<TextInput> get address => _address;
  Rx<TextInput> get description => _description;
  Rx<LatitudeInput> get latitude => _latitude;
  Rx<LongitudeInput> get longitude => _longitude;
  Rx<LocalityInput> get locality => _locality;

  void onAddressChanged(String value) {
    _isModifed.value = true;
    final address = TextInput.dirty(value);
    _address.value = address;
    _isValid.value = Formz.validate([
      address,
      _description.value,
      _locality.value,
      _image.value,
      _latitude.value,
      _longitude.value,
    ]);
  }

  void onLocalityChanged(String? value) {
    _isModifed.value = true;
    final locality = LocalityInput.dirty(value);
    _locality.value = locality;
    _isValid.value = Formz.validate([
      _address.value,
      _description.value,
      locality,
      _image.value,
      _latitude.value,
      _longitude.value,
    ]);
  }

  void onImageChanged(XFile value) {
    _isModifed.value = true;
    final image = ImageInput.dirty(value);
    _image.value = image;
    _isValid.value = Formz.validate([
      _address.value,
      _description.value,
      _locality.value,
      image,
      _latitude.value,
      _longitude.value,
    ]);
  }

  void onLatitudeChanged(String value) {
    _isModifed.value = true;
    final latitude = LatitudeInput.dirty(value);
    _latitude.value = latitude;
    _isValid.value = Formz.validate([
      _address.value,
      _description.value,
      _locality.value,
      _image.value,
      latitude,
      _longitude.value,
    ]);
  }

  void onLongitudeChanged(String value) {
    _isModifed.value = true;
    final longitude = LongitudeInput.dirty(value);
    _longitude.value = longitude;
    _isValid.value = Formz.validate([
      _address.value,
      _description.value,
      _locality.value,
      _image.value,
      _latitude.value,
      longitude,
    ]);
  }

  void onDescriptionChanged(String value) {
    _isModifed.value = true;
    final description = TextInput.dirty(value);
    _description.value = description;
    _isValid.value = Formz.validate([
      _address.value,
      description,
      _locality.value,
      _image.value,
      _latitude.value,
      _longitude.value,
    ]);
  }

  void onLocationChanged(LatLng? latLng, String address, String? locality) {
    if (latLng == null) return;
    onLatitudeChanged(latLng.latitude.toString());
    onLongitudeChanged(latLng.longitude.toString());
    onAddressChanged(address);
    onLocalityChanged(locality);
  }
    
  Future<bool> onSubmit() async {
    _isPosted.value = true;

    if (!_isModifed.value) return false;

    _isValid.value = Formz.validate([
      _address.value,
      _description.value,
      _locality.value,
      _image.value,
      _latitude.value,
      _longitude.value,
    ]);

    if (!_isValid.value) return false;

    final potholeLike = <String, dynamic>{};

    if (!_address.value.isPure) potholeLike['address'] = _address.value.value;
    if (!_description.value.isPure) potholeLike['description'] = _description.value.value;
    if (!_image.value.isPure) potholeLike['image'] = _image.value.value;
    if (!_latitude.value.isPure) potholeLike['latitude'] = _latitude.value.value;
    if (!_longitude.value.isPure) potholeLike['longitude'] = _longitude.value.value;
    if (!_locality.value.isPure) potholeLike['locality'] = _locality.value.value;

    _isPosting.value = true;
    try {
      return await _onSubmitCallback(potholeLike);
    } catch (e) {
      return false;
    } finally {
      _isPosting.value = false;
    }
  }
}
