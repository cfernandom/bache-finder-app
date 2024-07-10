import 'package:formz/formz.dart';

enum ImageValidationError { empty, format }

class ImageInput extends FormzInput<String, ImageValidationError> {
  const ImageInput.pure(super.value) : super.pure();
  const ImageInput.dirty(super.value) : super.dirty();
  
  @override
  ImageValidationError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return ImageValidationError.empty;
    }
    if (!value.endsWith('.jpg') && !value.endsWith('.jpeg') && !value.endsWith('.png')) {
      return ImageValidationError.format;
    }
    return null;
  }

  String? get errorMessage {
    final error = this.error;
    if (error == null) return null;
    if (error == ImageValidationError.empty) return 'La imagen es obligatoria';
    if (error == ImageValidationError.format) return 'El formato de la imagen no es valido.\nSolo se aceptan imagenes .jpg, .jpeg o .png';
    return null;
  }
}