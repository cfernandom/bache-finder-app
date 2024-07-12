import 'package:bache_finder_app/core/constants/locations.dart';
import 'package:formz/formz.dart';

enum LocalityInputValidationError { empty }

class LocalityInput extends FormzInput<String?, LocalityInputValidationError> {
  const LocalityInput.pure(super.value) : super.pure();
  const LocalityInput.dirty(super.value) : super.dirty();

  @override
  LocalityInputValidationError? validator(String? value) {
    if (value == null || !Locations.bogotaLocalities.contains(value)) {
      return LocalityInputValidationError.empty;
    }
    return null;
  }

  String? get errorMessage {
    final error = this.error;
    if (error == null) return null;
    if (error == LocalityInputValidationError.empty) return 'La localidad es obligatoria';
    return null;
  }
}