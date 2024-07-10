import 'package:bache_finder_app/features/pothole/domain/entities/pothole.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/image_input.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/latitude_input.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/longitude_input.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/text_input.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';

class PotholeFormController extends GetxController {
  final Future<bool> Function(Map<String, dynamic> potholeLike)
      _onSubmitCallback;

  final Rx<TextInput> _address;
  final Rx<ImageInput> _image;
  final Rx<LatitudeInput> _latitude;
  final Rx<LongitudeInput> _longitude;

  PotholeFormController(
    Pothole? pothole, {
    required onSubmitCallback,
  })  : _onSubmitCallback = onSubmitCallback,
        _address = TextInput.pure(pothole?.address ?? '').obs,
        _image = ImageInput.pure(pothole?.image ?? '').obs,
        _latitude = LatitudeInput.pure(pothole?.latitude.toString() ?? '').obs,
        _longitude =
            LongitudeInput.pure(pothole?.longitude.toString() ?? '').obs;

  final _isPosted = false.obs;
  final _isPosting = false.obs;
  final _isValid = false.obs;
  final _isModifed = false.obs;

  bool get isPosted => _isPosted.value;
  bool get isPosting => _isPosting.value;
  Rx<ImageInput> get image => _image;
  Rx<TextInput> get address => _address;
  Rx<LatitudeInput> get latitude => _latitude;
  Rx<LongitudeInput> get longitude => _longitude;

  void onAddressChanged(String value) {
    _isModifed.value = true;
    final address = TextInput.dirty(value);
    _address.value = address;
    _isValid.value = Formz.validate([
      address,
      _image.value,
      _latitude.value,
      _longitude.value,
    ]);
  }

  void onImageChanged(String value) {
    _isModifed.value = true;
    final image = ImageInput.dirty(value);
    _image.value = image;
    _isValid.value = Formz.validate([
      _address.value,
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
      _image.value,
      _latitude.value,
      longitude,
    ]);
  }

  void onDescriptionChanged(String value) {
    _isModifed.value = true;
    final description = TextInput.dirty(value);
    // _description.value = description;
    _isValid.value = Formz.validate([
      _address.value,
      _image.value,
      _latitude.value,
      _longitude.value,
      description,
    ]);
  }

  Future<bool> onSubmit() async {
    _isPosted.value = true;

    if (!_isModifed.value) return false;

    _isValid.value = Formz.validate([
      _address.value,
      _image.value,
      _latitude.value,
      _longitude.value,
    ]);

    if (!_isValid.value) return false;

    final potholeLike = <String, dynamic>{};

    if (!_address.value.isPure) potholeLike['address'] = _address.value.value;
    if (!_image.value.isPure) potholeLike['image'] = _image.value.value;
    if (!_latitude.value.isPure) potholeLike['latitude'] = _latitude.value.value;
    if (!_longitude.value.isPure) potholeLike['longitude'] = _longitude.value.value;

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
