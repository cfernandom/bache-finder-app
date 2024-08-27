import 'package:bache_finder_app/core/router/app_pages.dart';
import 'package:bache_finder_app/features/pothole/infrastructure/constants/pothole_constants.dart';
import 'package:bache_finder_app/features/pothole/presentation/controllers/forms/pothole_form_controller.dart';
import 'package:bache_finder_app/features/pothole/presentation/controllers/pothole_controller.dart';
import 'package:bache_finder_app/features/pothole/presentation/widgets/locality_selector_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/gap_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/image_viewer_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/outlined_button_icon_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/selector_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/snackbar_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/text_field_rx_widget.dart';
import 'package:bache_finder_app/features/shared/services/camera_gallery_service_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PotholeScreen extends GetView<PotholeController> {
  const PotholeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5FB),
      key: scaffoldKey,
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : const _MainView()),
      floatingActionButton: Obx(
        () => controller.isLoading.value
            ? const SizedBox.shrink()
            : _SaveButton(scaffoldKey),
      ),
    );
  }
}

class _SaveButton extends GetView<PotholeFormController> {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const _SaveButton(this.scaffoldKey);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FloatingActionButton.extended(
        onPressed: controller.isModifed
            ? () async {
                final result = await controller.onSubmit();

                if (scaffoldKey.currentContext == null) return;

                if (result) {
                  SnackbarWidget.show(scaffoldKey.currentContext!,
                      message: 'Bache guardado con éxito');
                } else {
                  SnackbarWidget.show(scaffoldKey.currentContext!,
                      message: 'Error al guardar bache');
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Reporte de bache',
                    style: Theme.of(context).textTheme.titleLarge),
                controller.pothole.value != null
                    ? const _BasicInformationView()
                    : const _BasicFormView(),
                controller.pothole.value != null
                    ? const _AdditionalFormView()
                    : const SizedBox.shrink(),
                const GapWidget(size: 80.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BasicInformationView extends GetView<PotholeController> {
  const _BasicInformationView();

  @override
  Widget build(BuildContext context) {
    final pothole = controller.pothole.value;
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const GapWidget(size: 16.0),
        Text('Foto del bache', style: Theme.of(context).textTheme.titleSmall),
        const GapWidget(size: 8.0),
        const _ImageViewer(),
        const GapWidget(size: 16.0),
        Text('Ubicación del bache',
            style: Theme.of(context).textTheme.titleSmall),
        const GapWidget(size: 8.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0xFFDFF2FA),
          ),
          child: Column(children: [
            ExpandText('Latitud ', pothole?.latitude.toString() ?? ''),
            ExpandText('Longitud ', pothole?.longitude.toString() ?? ''),
            ExpandText('Dirección ', pothole?.address ?? ''),
            ExpandText('Localidad ', pothole?.locality ?? ''),
          ]),
        ),
        const GapWidget(size: 8.0),
        Text('Detalles del bache',
            style: Theme.of(context).textTheme.titleSmall),
        const GapWidget(size: 8.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0xFFDFF2FA),
          ),
          child: const Column(
            children: [
              _DescriptionInput(),
              GapWidget(size: 4.0),
            ],
          ),

        ),
        const GapWidget(size: 16.0),
      ]),
    );
  }
}

class ExpandText extends StatelessWidget {
  const ExpandText(this.leftText, this.rightText, {super.key});
  final String leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(leftText)),
        Expanded(child: Text(rightText)),
      ],
    );
  }
}

class _BasicFormView extends StatelessWidget {
  const _BasicFormView();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GapWidget(size: 16.0),
          Text('Foto del bache', style: Theme.of(context).textTheme.titleSmall),
          const GapWidget(size: 8.0),
          const _ImageViewer(),
          const GapWidget(size: 8.0),
          const Row(
            children: [
              Expanded(child: _UploadPhotoButton()),
              if (!kIsWeb) ...[
                GapWidget(size: 8.0),
                Expanded(child: _TakePhotoButton()),
              ],
            ],
          ),
          const GapWidget(size: 16.0),
          Text('Ubicación del bache',
              style: Theme.of(context).textTheme.titleSmall),
          const GapWidget(size: 8.0),
          const _LocationPickerButton(),
          const GapWidget(size: 8.0),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color(0xFFDFF2FA),
            ),
            child: const Column(children: [
              _LatitudeInput(),
              _LongitudeInput(),
              GapWidget(size: 8.0),
              _AddressInput(),
              GapWidget(size: 8.0),
              _LocalitySelector(),
              GapWidget(size: 4.0),
            ]),
          ),
          const GapWidget(size: 16.0),
          Text('Detalles del bache',
              style: Theme.of(context).textTheme.titleSmall),
          const GapWidget(size: 8.0),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color(0xFFDFF2FA),
            ),
            child: const Column(children: [
              _DescriptionInput(),
              GapWidget(size: 4.0),
            ]),
          ),
        ],
      ),
    );
  }
}

class _AdditionalFormView extends StatelessWidget {
  const _AdditionalFormView();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GapWidget(size: 16.0),
          Text('Tipo de bache', style: Theme.of(context).textTheme.titleSmall),
          const GapWidget(size: 8.0),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color(0xFFDFF2FA),
            ),
            child: const Column(children: [
              Row(
                children: [
                  Expanded(child: _TypeSelector()),
                  GapWidget(size: 8.0),
                  _PredictPotholeButton(),
                ],
              ),
              _PredictionDetails(),
            ]),
          ),
          const GapWidget(size: 16.0),
        ],
      ),
    );
  }
}

class _LocationPickerButton extends GetView<PotholeFormController> {
  const _LocationPickerButton();

  void _onPressed(BuildContext context) async {
    final currentLocation = GoRouterState.of(context).matchedLocation;
    context.push('$currentLocation/${AppPaths.locationPicker}');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.0,
      child: OutlinedButtonIconWidget(
        onPressed: () => _onPressed(context),
        label: 'Seleccionar ubicación',
        icon: Icons.location_on,
      ),
    );
  }
}

class _AddressInput extends GetView<PotholeFormController> {
  const _AddressInput();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Text('Dirección',
                  style: Theme.of(context).textTheme.bodyMedium)),
          Expanded(
            child: Obx(
              () => TextFieldRxWidget(
                label: 'Dirección',
                maxLines: 2,
                initialValue: controller.address.value.value,
                keyboardType: TextInputType.text,
                onChanged: controller.onAddressChanged,
                errorMessage: controller.isPosted
                    ? controller.address.value.errorMessage
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DescriptionInput extends GetView<PotholeFormController> {
  const _DescriptionInput();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Descripción', style: Theme.of(context).textTheme.bodyMedium),
        const GapWidget(size: 8.0),
        Obx(
          () => TextFieldRxWidget(
            label: 'Descripción',
            maxLines: 6,
            initialValue: controller.description.value.value,
            keyboardType: TextInputType.text,
            onChanged: controller.onDescriptionChanged,
            errorMessage: controller.isPosted
                ? controller.description.value.errorMessage
                : null,
          ),
        ),
      ],
    );
  }
}

class _LocalitySelector extends GetView<PotholeFormController> {
  const _LocalitySelector();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Text('Localidad',
                  style: Theme.of(context).textTheme.bodyMedium)),
          Expanded(
            child: Obx(
              () => LocalitySelectorWidget(
                onChanged: controller.onLocalityChanged,
                initialValue: controller.locality.value.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeSelector extends GetView<PotholeFormController> {
  const _TypeSelector();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 40.0,
        child: SelectorWidget(
          onChanged: controller.onTypeChanged,
          initialValue: controller.type.value.value,
          items: PotholeConstants.types,
        ),
      ),
    );
  }
}

class _LatitudeInput extends GetView<PotholeFormController> {
  const _LatitudeInput();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: Text('Latitud')),
          Expanded(
            child: Obx(
              () => Text(controller.latitude.value.value),
            ),
          ),
        ],
      ),
    );
  }
}

class _LongitudeInput extends GetView<PotholeFormController> {
  const _LongitudeInput();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: Text('Longitud')),
          Expanded(
            child: Obx(
              () => Text(controller.longitude.value.value),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageViewer extends GetView<PotholeFormController> {
  const _ImageViewer();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(minHeight: 250, maxHeight: 500),
        child: Obx(() => ImageViewerWidget(controller.image.value.value.path)),
      ),
    );
  }
}

class _PredictionDetails extends GetView<PotholeFormController> {
  const _PredictionDetails();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return ExpansionTile(
          title: const Text('Ver predicciones'),
          initiallyExpanded: false,
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
          childrenPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          minTileHeight: 12.0,
          expandedAlignment: Alignment.topLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          backgroundColor: Colors.transparent,
          dense: true,
          collapsedBackgroundColor: Colors.transparent,
          collapsedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            side: BorderSide(color: Colors.transparent),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            side: BorderSide(color: Colors.transparent),
          ),
          children: [
            ...controller.weights.map(
              (weight) => Text(weight.toString()),
            )
          ],
        );
      },
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
    return SizedBox(
      height: 48,
      child: OutlinedButtonIconWidget(
        onPressed: onPressed,
        label: 'Seleccionar foto',
        icon: Icons.photo,
      ),
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
    return SizedBox(
      height: 48,
      child: OutlinedButtonIconWidget(
        onPressed: onPressed,
        label: 'Tomar foto',
        icon: Icons.camera_alt,
      ),
    );
  }
}

class _PredictPotholeButton extends GetView<PotholeFormController> {
  const _PredictPotholeButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: OutlinedButtonIconWidget(
        onPressed: controller.onPredict,
        label: 'Predecir',
        icon: Icons.insights,
      ),
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
