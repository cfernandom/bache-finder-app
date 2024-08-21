
import 'package:formz/formz.dart';

enum TextAreaValidationError { longLenght }

class TextAreaInput extends FormzInput<String, TextAreaValidationError> {
  const TextAreaInput.pure(super.value) : super.pure();
  const TextAreaInput.dirty(super.value) : super.dirty();

  @override
  TextAreaValidationError? validator(String value) {
    if (value.length > 1000) {
      return TextAreaValidationError.longLenght;
    }
    return null;
  }

  String? get errorMessage {
    final error = this.error;
    if (error == null) return null;
    if (error == TextAreaValidationError.longLenght) return 'El texto no puede ser mayor a 1000 caracteres';
    return null;
  }
}
