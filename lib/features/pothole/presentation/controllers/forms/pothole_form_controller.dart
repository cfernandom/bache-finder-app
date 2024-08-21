import 'dart:convert';

import 'package:bache_finder_app/core/errors/failures/failure.dart';
import 'package:bache_finder_app/features/pothole/domain/entities/pothole.dart';
import 'package:bache_finder_app/features/pothole/domain/entities/pothole_prediction.dart';
import 'package:bache_finder_app/features/pothole/infrastructure/constants/pothole_constants.dart';
import 'package:bache_finder_app/features/pothole/infrastructure/inputs/type_input.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/image_input.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/latitude_input.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/locality_input.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/longitude_input.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/text_area_input.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/text_input.dart';
import 'package:formz/formz.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_location_picker/map_location_picker.dart';

class PotholeFormController extends GetxController {
  final Future<bool> Function(Map<String, dynamic> potholeLike)
      _onSubmitCallback;
  final Future<Either<Failure, PotholePrediction>> Function()
      _onPredictCallback;

  final Rx<TextInput> _address;
  final Rx<TextAreaInput> _description;
  final Rx<ImageInput> _image;
  final Rx<LatitudeInput> _latitude;
  final Rx<LongitudeInput> _longitude;
  final Rx<LocalityInput> _locality;
  final Rx<TypeInput> _type;
  final RxList<double> _weights;

  PotholeFormController(
    Pothole? pothole, {
    required onSubmitCallback,
    required Future<Either<Failure, PotholePrediction>> Function()
        onPredictCallback,
  })  : _onSubmitCallback = onSubmitCallback,
        _onPredictCallback = onPredictCallback,
        _address = TextInput.pure(pothole?.address ?? '').obs,
        _description = TextAreaInput.pure(pothole?.description ?? '').obs,
        _image = ImageInput.pure(XFile(pothole?.image ?? '')).obs,
        _latitude = LatitudeInput.pure(pothole?.latitude.toString() ?? ' -').obs,
        _longitude =
            LongitudeInput.pure(pothole?.longitude.toString() ?? ' -').obs,
        _locality = LocalityInput.pure(pothole?.locality).obs,
        _type =
            TypeInput.pure(pothole?.type ?? PotholeConstants.types.first).obs,
        _weights = (pothole?.weights ?? []).obs;

  final _isPosted = false.obs;
  final _isPosting = false.obs;
  final _isValid = false.obs;
  final _isModifed = false.obs;

  bool get isPosted => _isPosted.value;
  bool get isPosting => _isPosting.value;
  bool get isModifed => _isModifed.value;
  Rx<ImageInput> get image => _image;
  Rx<TextInput> get address => _address;
  Rx<TextAreaInput> get description => _description;
  Rx<LatitudeInput> get latitude => _latitude;
  Rx<LongitudeInput> get longitude => _longitude;
  Rx<LocalityInput> get locality => _locality;
  Rx<TypeInput> get type => _type;
  RxList<double> get weights => _weights;

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
      _type.value,
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
      _type.value,
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
      _type.value,
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
      _type.value,
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
      _type.value,
    ]);
  }

  void onDescriptionChanged(String value) {
    _isModifed.value = true;
    final description = TextAreaInput.dirty(value);
    _description.value = description;
    _isValid.value = Formz.validate([
      _address.value,
      description,
      _locality.value,
      _image.value,
      _latitude.value,
      _longitude.value,
      _type.value,
    ]);
  }

  void onTypeChanged(String value) {
    _isModifed.value = true;
    final type = TypeInput.dirty(value);
    _type.value = type;
    _isValid.value = Formz.validate([
      _address.value,
      _description.value,
      _locality.value,
      _image.value,
      _latitude.value,
      _longitude.value,
      type,
    ]);
  }

  void onLocationChanged(LatLng? latLng, String address, String? locality) {
    if (latLng == null) return;
    onLatitudeChanged(latLng.latitude.toString());
    onLongitudeChanged(latLng.longitude.toString());
    onAddressChanged(address);
    onLocalityChanged(locality);
  }

  Future<bool> onPredict() async {
    final result = await _onPredictCallback();

    result.fold(
      (failure) => {},
      (potholePrediction) {
        _isModifed.value = true;
        _weights.value = potholePrediction.weights;
        _type.value = TypeInput.dirty(potholePrediction.type);
      },
    );

    return result.isRight();
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
    if (!_type.value.isPure) potholeLike['type'] = _type.value.value;
    potholeLike['predictions'] = jsonEncode(_weights.toList());

    _isPosting.value = true;
    try {
      final result = await _onSubmitCallback(potholeLike);
      _isModifed.value = false;
      return result;
    } catch (e) {
      return false;
    } finally {
      _isPosting.value = false;
    }
  }
}
