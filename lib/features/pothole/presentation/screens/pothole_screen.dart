import 'package:bache_finder_app/features/pothole/presentation/controllers/forms/pothole_form_controller.dart';
import 'package:bache_finder_app/features/pothole/presentation/controllers/pothole_controller.dart';
import 'package:bache_finder_app/features/pothole/presentation/widgets/locality_selector_widget.dart';
import 'package:bache_finder_app/features/pothole/presentation/widgets/location_picker_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/icon_button_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/image_viewer_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/text_field_rx_widget.dart';
import 'package:bache_finder_app/features/shared/services/camera_gallery_service_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';

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
              Text('Formulario de bache', style: Theme.of(context).textTheme.titleLarge),
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
    return Column(
      children: [
        Text('Foto del bache', style: Theme.of(context).textTheme.titleMedium),
        const _ImageViewer(),
        const Row(
          children: [
            Expanded(child: _UploadPhotoButton()),
            kIsWeb ? SizedBox.shrink() : Expanded(child: _TakePhotoButton()),
          ],
        ),
        Text('Ubicación del bache', style: Theme.of(context).textTheme.titleMedium),
        const _LocationPickerButton(),
        const _LatitudeInput(),
        const _LongitudeInput(),
        const _AddressInput(),
        const _LocalitySelector(),
      ],
    );
  }
}

class _LocationPickerButton extends GetView<PotholeFormController> {
  const _LocationPickerButton();

  void _onLocationChanged(
    LatLng? latLng,
    String address,
    String? locality,
  ) {
    if (latLng != null) {
      controller.onLatitudeChanged(latLng.latitude.toString());
      controller.onLongitudeChanged(latLng.longitude.toString());
      controller.onAddressChanged(address);
      controller.onLocalityChanged(locality);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        child: const Text('Seleccionar ubicación'),
        onPressed: () async {
          final currentLat = double.tryParse(controller.latitude.value.value);
          final currentLng = double.tryParse(controller.longitude.value.value);
          final currentLatLng = currentLat != null && currentLng != null
              ? LatLng(currentLat, currentLng)
              : null;

          Get.to(() => LocationPickerScreen(
                onChanged: _onLocationChanged,
                currentLatLng: currentLatLng,
              ));
        },
      ),
    );
  }
}

class _AddressInput extends GetView<PotholeFormController> {
  const _AddressInput();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFieldRxWidget(
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
      () => Text('Latitud: ${controller.latitude.value.value}'),
    );
  }
}

class _LongitudeInput extends GetView<PotholeFormController> {
  const _LongitudeInput();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text('Longitud: ${controller.longitude.value.value}'),
    );
  }
}

class _ImageViewer extends GetView<PotholeFormController> {
  const _ImageViewer();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 250, maxHeight: 500),
      child: Obx(() => ImageViewerWidget(controller.image.value.value.path)),
    );
  }
}

class _UploadPhotoButton extends GetView<PotholeFormController> {
  const _UploadPhotoButton();

  void onPressed() async {
    final photo = await CameraGalleryServiceImpl().selectPhoto();
    if (photo == null) return;
    controller.onImageChanged(photo);
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
    final photo = await CameraGalleryServiceImpl().takePhoto();
    if (photo == null) return;

    controller.onImageChanged(photo);
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

// class _SubmitButton extends GetView<PotholeFormController> {
//   const _SubmitButton();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => IconButtonWidget(
//           onPressed: controller.isPosting ? null : controller.onSubmit,
//           label: 'Enviar',
//           icon: Icons.send,
//         ));
//   }
// }
