import 'package:bache_finder_app/features/pothole/infrastructure/constants/pothole_constants.dart';
import 'package:formz/formz.dart';

enum TypeInputValidationError { invalid }

class TypeInput extends FormzInput<String, TypeInputValidationError> {
  const TypeInput.pure(super.value) : super.pure();
  const TypeInput.dirty(super.value) : super.dirty();

  @override
  TypeInputValidationError? validator(String value) {
    if (!PotholeConstants.types.contains(value)) {
      return TypeInputValidationError.invalid;
    }
    return null;
  }

  String? get errorMessage {
    final error = this.error;
    if (error == null) return null;
    if (error == TypeInputValidationError.invalid) return 'Tipo de bache inválido';
    return null;
  }
}