import 'package:formz/formz.dart';

enum LatitudeValidationError { empty, invalid }

class LatitudeInput extends FormzInput<double?, LatitudeValidationError> {
  const LatitudeInput.pure() : super.pure(null);
  const LatitudeInput.dirty(super.value) : super.dirty();

  @override
  LatitudeValidationError? validator(double? value) {
    if (value == null || value == 0) {
      return LatitudeValidationError.empty;
    }
    if (value < -90 || value > 90) {
      return LatitudeValidationError.invalid;
    }
    return null;
  }

  String? get errorMessage {
    final error = this.error;
    if (error == null) return null;
    if (error == LatitudeValidationError.empty) return 'La latitud es obligatoria';
    if (error == LatitudeValidationError.invalid) return 'La latitud debe estar entre -90 y 90';
    return null;
  }
}
