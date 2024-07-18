import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';

enum ImageValidationError { empty, format }

class ImageInput extends FormzInput<XFile, ImageValidationError> {
  const ImageInput.pure(super.value) : super.pure();
  const ImageInput.dirty(super.value) : super.dirty();

  @override
  ImageValidationError? validator(XFile value) {
    if (value.path.trim().isEmpty) {
      return ImageValidationError.empty;
    }

    final format = value.path.split('.').last;
    final formatFromMimeType = value.mimeType?.split('/')[1];

    final validFormats = ['jpg', 'jpeg', 'png'];
    if (!validFormats.contains(format) &&
        !validFormats.contains(formatFromMimeType)) {
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
