import 'package:formz/formz.dart';

enum LongitudeValidationError { empty, invalid }

class LongitudeInput extends FormzInput<double?, LongitudeValidationError> {
  const LongitudeInput.pure() : super.pure(null);
  const LongitudeInput.dirty(super.value) : super.dirty();

  @override
  LongitudeValidationError? validator(double? value) {
    if (value == null || value == 0) {
      return LongitudeValidationError.empty;
    }
    if (value < -180 || value > 180) {
      return LongitudeValidationError.invalid;
    }
    return null;
  }

  String? get errorMessage {
    final error = this.error;
    if (error == null) return null;
    if (error == LongitudeValidationError.empty) return 'La longitud es obligatoria';
    if (error == LongitudeValidationError.invalid) return 'La longitud debe estar entre -180 y 180';
    return null;
  }
}