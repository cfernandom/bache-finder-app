import 'package:formz/formz.dart';

enum LatitudeValidationError { empty, invalid, formatted }

class LatitudeInput extends FormzInput<String, LatitudeValidationError> {
  const LatitudeInput.pure(super.value) : super.pure();
  const LatitudeInput.dirty(super.value) : super.dirty();

  @override
  LatitudeValidationError? validator(String value) {
    if (value == '') {
      return LatitudeValidationError.empty;
    }
    if (value.contains(',')) {
      return LatitudeValidationError.formatted;
    }
    final valueAsDouble = double.tryParse(value);

    if (valueAsDouble == null || valueAsDouble < -90 || valueAsDouble > 90) {
      return LatitudeValidationError.invalid;
    }
    return null;
  }

  String? get errorMessage {
    final error = this.error;
    if (error == null) return null;
    if (error == LatitudeValidationError.empty) return 'La latitud es obligatoria';
    if (error == LatitudeValidationError.formatted) return 'El formato no es válido';
    if (error == LatitudeValidationError.invalid) return 'La latitud debe estar entre -90 y 90';
    return null;
  }
}
