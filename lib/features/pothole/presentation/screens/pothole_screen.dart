import 'package:bache_finder_app/features/pothole/presentation/controllers/forms/pothole_form_controller.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/icon_button_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/image_viewer_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/text_field_widget.dart';
import 'package:bache_finder_app/features/shared/services/camera_gallery_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PotholeScreen extends StatelessWidget {
  const PotholeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _MainView(),
    );
  }
}

class _MainView extends StatelessWidget {
  const _MainView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Reportar Bache'),
              _FormView(),
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
        keyboardType: TextInputType.text,
        onChanged: controller.onAddressChanged,
        errorMessage:
            controller.isPosted ? controller.address.errorMessage : null,
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
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: (value) =>
            controller.onLatitudeChanged(double.tryParse(value)),
        errorMessage:
            controller.isPosted ? controller.latitude.errorMessage : null,
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
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: (value) =>
            controller.onLongitudeChanged(double.tryParse(value)),
        errorMessage:
            controller.isPosted ? controller.longitude.errorMessage : null,
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
