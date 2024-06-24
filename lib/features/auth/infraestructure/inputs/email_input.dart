import 'package:formz/formz.dart';

enum EmailValidationError { empty, invalid }

class EmailInput extends FormzInput<String, EmailValidationError> {
  const EmailInput.pure([super.value = '']) : super.pure();
  const EmailInput.dirty([super.value = '']) : super.dirty();

  static final _emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return EmailValidationError.empty;
    }
    if (!_emailRegExp.hasMatch(value)) {
      return EmailValidationError.invalid;
    }
    return null;
  }

  String? get errorMessage {
    final error = this.error;
    if (error == null) return null;
    if (error == EmailValidationError.empty) return 'El correo electrónico es obligatorio';
    if (error == EmailValidationError.invalid) return 'El correo electrónico no es valido';
    return null;
  }
}
