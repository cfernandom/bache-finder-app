import 'package:bache_finder_app/features/shared/infrastructure/inputs/image_input.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/latitude_input.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/text_input.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';

class PotholeFormController extends GetxController {
  final Future<bool> Function(Map<String, dynamic> potholeLike)
      _onSubmitCallback;

  PotholeFormController(String potholeId, {required onSubmitCallback})
      : _onSubmitCallback = onSubmitCallback;
      
  final _isPosted = false.obs;
  final _isPosting = false.obs;
  final _isValid = false.obs;
  final _address = const TextInput.pure().obs;
  final _image = const ImageInput.pure().obs;
  final _latitude = const LatitudeInput.pure().obs;
  final _longitude = const LatitudeInput.pure().obs;

  bool get isPosted => _isPosted.value;
  bool get isPosting => _isPosting.value;
  Rx<ImageInput> get image => _image;
  TextInput get address => _address.value;
  LatitudeInput get latitude => _latitude.value;
  LatitudeInput get longitude => _longitude.value;

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

  void onLatitudeChanged(double? value) {
    final latitude = LatitudeInput.dirty(value);
    _latitude.value = latitude;
    _isValid.value = Formz.validate([
      _address.value,
      _image.value,
      latitude,
      _longitude.value,
    ]);
  }

  void onLongitudeChanged(double? value) {
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
