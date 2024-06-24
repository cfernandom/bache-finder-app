import 'package:formz/formz.dart';

enum PasswordValidationError { empty, shortLenght, longLenght }

class PasswordInput extends FormzInput<String, PasswordValidationError> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return PasswordValidationError.empty;
    }
    if (value.length < 8) {
      return PasswordValidationError.shortLenght;
    }
    if (value.length > 50) {
      return PasswordValidationError.longLenght;
    }
    return null;
  }

  String? get errorMessage {
    final error = this.error;
    if (error == null) return null;
    if (error == PasswordValidationError.empty) return 'La contraseña es obligatoria';
    if (error == PasswordValidationError.shortLenght) return 'La contraseña es muy corta';
    if (error == PasswordValidationError.longLenght) return 'La contraseña es muy larga';
    return null;
  }
}
