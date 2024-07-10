import 'package:formz/formz.dart';

enum LongitudeValidationError { empty, invalid, formatted }

class LongitudeInput extends FormzInput<String, LongitudeValidationError> {
  const LongitudeInput.pure() : super.pure('');
  const LongitudeInput.dirty(super.value) : super.dirty();

  @override
  LongitudeValidationError? validator(String value) {
    if (value == '') {
      return LongitudeValidationError.empty;
    }
    if (value.contains(',')) {
      return LongitudeValidationError.formatted;
    }

    final valueAsDouble = double.tryParse(value);

    if (valueAsDouble == null || valueAsDouble < -180 || valueAsDouble > 180) {
      return LongitudeValidationError.invalid;
    }
    return null;
  }

  String? get errorMessage {
    final error = this.error;
    if (error == null) return null;
    if (error == LongitudeValidationError.empty) return 'La longitud es obligatoria';
    if (error == LongitudeValidationError.formatted) return 'El formato no es válido';
    if (error == LongitudeValidationError.invalid) return 'La longitud debe estar entre -180 y 180';
    return null;
  }
}
