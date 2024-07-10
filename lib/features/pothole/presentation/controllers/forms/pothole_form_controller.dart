import 'package:bache_finder_app/features/pothole/domain/entities/pothole.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/image_input.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/latitude_input.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/text_input.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';

class PotholeFormController extends GetxController {
  final Future<bool> Function(Map<String, dynamic> potholeLike)
      _onSubmitCallback;

  final Rx<TextInput> _address;
  final Rx<ImageInput> _image;
  final Rx<LatitudeInput> _latitude;
  final Rx<LatitudeInput> _longitude;

  PotholeFormController(
    Pothole? pothole, {
    required onSubmitCallback,
  })  : _onSubmitCallback = onSubmitCallback,
        _address = TextInput.dirty(pothole?.address ?? '').obs,
        _image = ImageInput.dirty(pothole?.image ?? '').obs,
        _latitude = LatitudeInput.dirty(pothole?.latitude.toString() ?? '').obs,
        _longitude = LatitudeInput.dirty(pothole?.longitude.toString() ?? '').obs;

  final _isPosted = false.obs;
  final _isPosting = false.obs;
  final _isValid = false.obs;

  bool get isPosted => _isPosted.value;
  bool get isPosting => _isPosting.value;
  Rx<ImageInput> get image => _image;
  Rx<TextInput> get address => _address;
  Rx<LatitudeInput> get latitude => _latitude;
  Rx<LatitudeInput> get longitude => _longitude;

  void onAddressChanged(String value) {
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
    final longitude = LatitudeInput.dirty(value);
    _longitude.value = longitude;
    _isValid.value = Formz.validate([
      _address.value,
      _image.value,
      _latitude.value,
      longitude,
    ]);
  }

  void onDescriptionChanged(String value) {
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

  void _touchAllFields() {
    final address = TextInput.dirty(_address.value.value);
    final image = ImageInput.dirty(_image.value.value);
    final latitude = LatitudeInput.dirty(_latitude.value.value);
    final longitude = LatitudeInput.dirty(_longitude.value.value);

    _address.value = address;
    _image.value = image;
    _latitude.value = latitude;
    _longitude.value = longitude;

    _isValid.value = Formz.validate([
      address,
      image,
      latitude,
      longitude,
    ]);
    _isPosted.value = true;
  }

  Future<bool> onSubmit() async {
    _touchAllFields();

    if (!_isValid.value) return false;

    final potholeLike = {
      'address': _address.value.value,
      'image': _image.value.value,
      'latitude': _latitude.value.value,
      'longitude': _longitude.value.value,
      'description': 'description',
    };

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
