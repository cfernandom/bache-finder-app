import 'package:bache_finder_app/features/shared/services/camera_gallery_service.dart';
import 'package:image_picker/image_picker.dart';

class CameraGalleryServiceImpl implements CameraGalleryService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<XFile?> selectPhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );

    final format = photo?.mimeType ?? photo?.path.split('.').last;

    if (format != null) {
      return photo;
    }

    return null;
  }

  @override
  Future<XFile?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 90,
      preferredCameraDevice: CameraDevice.rear,
    );

    final format = photo?.mimeType ?? photo?.name.split('.').last;

    if (format != null) {
      return photo;
    }

    return null;
  }
}
