import 'package:formz/formz.dart';

enum TextInputValidationError { empty, longLenght }

class TextInput extends FormzInput<String, TextInputValidationError> {
  const TextInput.pure() : super.pure('');
  const TextInput.dirty(super.value) : super.dirty();

  @override
  TextInputValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return TextInputValidationError.empty;
    }
    if (value.length > 250) {
      return TextInputValidationError.longLenght;
    }
    return null;
  }

  String? get errorMessage {
    final error = this.error;
    if (error == null) return null;
    if (error == TextInputValidationError.empty) return 'Este campo es obligatorio';
    if (error == TextInputValidationError.longLenght) return 'El texto no puede ser mayor a 250 caracteres';
    return null;
  }
}
