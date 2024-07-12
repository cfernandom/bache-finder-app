import 'package:bache_finder_app/features/pothole/presentation/controllers/forms/pothole_form_controller.dart';
import 'package:bache_finder_app/features/pothole/presentation/controllers/pothole_controller.dart';
import 'package:bache_finder_app/features/pothole/presentation/widgets/locality_selector_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/icon_button_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/image_viewer_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/text_field_widget.dart';
import 'package:bache_finder_app/features/shared/services/camera_gallery_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PotholeScreen extends GetView<PotholeController> {
  const PotholeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const _MainView(),
      floatingActionButton: Obx(
        () => controller.isLoading.value
            ? const SizedBox.shrink()
            : const _SaveButton(),
      ),
    );
  }
}

class _SaveButton extends GetView<PotholeFormController> {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FloatingActionButton.extended(
        onPressed: controller.isModifed
            ? () async {
                final result = await controller.onSubmit();
                if (result) {
                  Get.snackbar(
                    'Bache guardado',
                    'Se ha guardado el bache correctamente',
                    snackPosition: SnackPosition.TOP,
                    backgroundGradient: LinearGradient(
                        colors: [Colors.green[300]!, Colors.green[100]!]),
                    margin: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 16),
                  );
                } else {
                  Get.snackbar(
                    'Error',
                    'No se ha podido guardar el bache.',
                    snackPosition: SnackPosition.TOP,          
                    backgroundGradient: LinearGradient(
                        colors: [Colors.red[300]!, Colors.red[100]!]),
                    margin: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 16),
                  );
                }
              }
            : null,
        icon: controller.isPosting
            ? const CircularProgressIndicator()
            : const Icon(Icons.save, color: Colors.white),
        label:
            const Text('Guardar bache', style: TextStyle(color: Colors.white)),
        backgroundColor: controller.isModifed
            ? Theme.of(context).colorScheme.primary
            : Colors.grey[300],
      ),
    );
  }
}

class _MainView extends GetView<PotholeController> {
  const _MainView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Formulario de bache'),
              Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : const _FormView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormView extends StatelessWidget {
  const _FormView();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Ubicación del bache'),
        _AddressInput(),
        _LatitudeInput(),
        _LongitudeInput(),
        _LocalitySelector(),
        Text('Imagen del bache'),
        _ImageViewer(),
        _UploadPhotoButton(),
        _TakePhotoButton(),
        _SubmitButton(),
      ],
    );
  }
}

class _AddressInput extends GetView<PotholeFormController> {
  const _AddressInput();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFieldWidget(
        label: 'Dirección*',
        initialValue: controller.address.value.value,
        keyboardType: TextInputType.text,
        onChanged: controller.onAddressChanged,
        errorMessage:
            controller.isPosted ? controller.address.value.errorMessage : null,
      ),
    );
  }
}

class _LocalitySelector extends GetView<PotholeFormController> {
  const _LocalitySelector();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LocalitySelectorWidget(
        onChanged: controller.onLocalityChanged,
        initialValue: controller.locality.value.value,
      ),
    );
  }
}

class _LatitudeInput extends GetView<PotholeFormController> {
  const _LatitudeInput();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFieldWidget(
        label: 'Latitud*',
        initialValue: controller.latitude.value.value.toString(),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: (value) => controller.onLatitudeChanged(value),
        errorMessage:
            controller.isPosted ? controller.latitude.value.errorMessage : null,
      ),
    );
  }
}

class _LongitudeInput extends GetView<PotholeFormController> {
  const _LongitudeInput();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFieldWidget(
        label: 'Longitud*',
        initialValue: controller.longitude.value.value.toString(),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: (value) => controller.onLongitudeChanged(value),
        errorMessage: controller.isPosted
            ? controller.longitude.value.errorMessage
            : null,
      ),
    );
  }
}

class _ImageViewer extends GetView<PotholeFormController> {
  const _ImageViewer();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 250, maxHeight: 500),
      child: Obx(() => ImageViewerWidget(controller.image.value.value)),
    );
  }
}

class _UploadPhotoButton extends GetView<PotholeFormController> {
  const _UploadPhotoButton();

  void onPressed() async {
    final photoPath = await CameraGalleryServiceImpl().selectPhoto();
    if (photoPath == null) return;
    controller.onImageChanged(photoPath);
  }

  @override
  Widget build(BuildContext context) {
    return IconButtonWidget(
      onPressed: onPressed,
      label: 'Seleccionar foto',
      icon: Icons.photo,
    );
  }
}

class _TakePhotoButton extends GetView<PotholeFormController> {
  const _TakePhotoButton();

  void onPressed() async {
    final photoPath = await CameraGalleryServiceImpl().takePhoto();
    if (photoPath == null) return;

    controller.onImageChanged(photoPath);
  }

  @override
  Widget build(BuildContext context) {
    return IconButtonWidget(
      onPressed: onPressed,
      label: 'Tomar foto',
      icon: Icons.camera_alt,
    );
  }
}

class _SubmitButton extends GetView<PotholeFormController> {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return Obx(() => IconButtonWidget(
          onPressed: controller.isPosting ? null : controller.onSubmit,
          label: 'Enviar',
          icon: Icons.send,
        ));
  }
}
