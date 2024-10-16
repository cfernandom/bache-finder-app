import 'package:bache_finder_app/core/constants/app_colors.dart';
import 'package:bache_finder_app/core/router/app_pages.dart';
import 'package:bache_finder_app/features/pothole/infrastructure/constants/pothole_constants.dart';
import 'package:bache_finder_app/features/pothole/presentation/controllers/forms/pothole_form_controller.dart';
import 'package:bache_finder_app/features/pothole/presentation/controllers/pothole_controller.dart';
import 'package:bache_finder_app/features/pothole/presentation/widgets/container_form_widget.dart';
import 'package:bache_finder_app/features/pothole/presentation/widgets/locality_selector_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/filled_button_icon_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/gap_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/image_viewer_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/outlined_button_icon_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/selector_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/snackbar_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/text_field_rx_widget.dart';
import 'package:bache_finder_app/features/shared/services/camera_gallery_service_impl.dart';
import 'package:bache_finder_app/features/user/presentation/controllers/user_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PotholeScreen extends StatelessWidget {
  const PotholeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    final potholeController = Get.isRegistered<PotholeController>()
        ? Get.find<PotholeController>()
        : null;

    return potholeController == null
        ? const SizedBox.shrink()
        : Scaffold(
            backgroundColor: const Color(0xFFF4FAFD),
            key: scaffoldKey,
            body: Obx(() => potholeController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : _MainView(scaffoldKey)),
            floatingActionButton: Obx(
              () => potholeController.isLoading.value
                  ? const SizedBox.shrink()
                  : _SaveButton(scaffoldKey),
            ),
            appBar: AppBar(
              title: Obx(
                () {
                  final potholeId =
                      potholeController.pothole.value?.id ?? 'new';
                  return Text(
                      potholeId != 'new'
                          ? 'Reporte de Bache'
                          : 'Reportar bache',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white));
                },
              ),
              backgroundColor: const Color(0xFF2C5461),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
          );
  }
}

class _SaveButton extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const _SaveButton(this.scaffoldKey);

  @override
  Widget build(BuildContext context) {
    final potholeFormController = Get.isRegistered<PotholeFormController>()
        ? Get.find<PotholeFormController>()
        : null;
    return potholeFormController == null
        ? const SizedBox()
        : Obx(
            () => FloatingActionButton.extended(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              onPressed: potholeFormController.isModifed == true
                  ? () async {
                      final result = await potholeFormController.onSubmit();

                      if (scaffoldKey.currentContext == null) return;

                      if (result == true) {
                        SnackbarWidget.show(scaffoldKey.currentContext!,
                            message: 'Bache guardado con éxito');
                      } else {
                        SnackbarWidget.show(scaffoldKey.currentContext!,
                            message: 'Error al guardar bache');
                      }
                    }
                  : null,
              icon: potholeFormController.isPosting == true
                  ? const CircularProgressIndicator()
                  : Icon(Icons.save,
                      color: potholeFormController.isModifed == true
                          ? Colors.white
                          : Colors.black26),
              disabledElevation: 0,
              elevation: 4,
              label: Text('Guardar bache',
                  style: potholeFormController.isModifed == true
                      ? const TextStyle(color: Colors.white)
                      : const TextStyle(color: Colors.black26)),
              backgroundColor: potholeFormController.isModifed == true
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[200],
            ),
          );
  }
}

class _MainView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const _MainView(this.scaffoldKey);

  @override
  Widget build(BuildContext context) {
    final potholeController = Get.isRegistered<PotholeController>()
        ? Get.find<PotholeController>()
        : null;
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
                potholeController?.pothole.value != null
                    ? _ContentView(scaffoldKey)
                    : const _BasicFormView(),
                // controller.pothole.value != null
                //     ? const _AdditionalFormView()
                //     : const SizedBox.shrink(),
                const GapWidget(size: 80.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContentView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const _ContentView(this.scaffoldKey);

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final potholeController = Get.isRegistered<PotholeController>()
        ? Get.find<PotholeController>()
        : null;

    return Column(
      children: [
        const _BasicInformationView(),
        Obx(() {
          final isOwner = potholeController?.pothole.value?.userId ==
              userController.currentUser.value?.id;
          final canDeletePothole =
              userController.currentUser.value?.canDeletePothole() ?? false;
          return canDeletePothole || isOwner
              ? _DeletePotholeButton(scaffoldKey)
              : const SizedBox.shrink();
        }),
      ],
    );
  }
}

class _DeletePotholeButton extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const _DeletePotholeButton(this.scaffoldKey);

  void _onPressed(BuildContext context, PotholeController? controller) async {
    final confirmed = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Eliminar reporte de bache'),
            content:
                const Text('El reporte de bache se eliminará permanentemente'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Eliminar'),
              ),
            ],
          );
        });
    if (confirmed) {
      if (controller == null) return;
      final success = await controller.deletePothole();

      if (scaffoldKey.currentContext != null) {
        if (success) {
          SnackbarWidget.show(scaffoldKey.currentContext!,
              message: 'Reporte eliminado con éxito');
          Navigator.of(scaffoldKey.currentContext!).pop();
        } else {
          SnackbarWidget.show(scaffoldKey.currentContext!,
              message: 'Error al eliminar el reporte');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final potholeController = Get.isRegistered<PotholeController>()
        ? Get.find<PotholeController>()
        : null;
    return FilledButtonIconWidget(
      label: 'Eliminar reporte',
      icon: Icons.delete,
      color: Colors.redAccent[400]!,
      onPressed: () => _onPressed(context, potholeController),
    );
  }
}

class _BasicInformationView extends StatelessWidget {
  const _BasicInformationView();

  @override
  Widget build(BuildContext context) {
    final potholeController = Get.isRegistered<PotholeController>()
        ? Get.find<PotholeController>()
        : null;
    final pothole = potholeController?.pothole.value;
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const GapWidget(size: 16.0),
        Text('Foto del bache', style: Theme.of(context).textTheme.titleMedium),
        const GapWidget(size: 8.0),
        const ContainerFormWidget(
          child: _ImageViewer(),
        ),
        const GapWidget(size: 8.0),
        ContainerFormWidget(
          child: Column(children: [
            ExpandText(
                'Tipo de bache', potholeController?.pothole.value?.type ?? ''),
          ]),
        ),
        const GapWidget(size: 16.0),
        Text('Ubicación del bache',
            style: Theme.of(context).textTheme.titleMedium),
        const GapWidget(size: 8.0),
        ContainerFormWidget(
          child: Column(children: [
            ExpandText('Latitud ', pothole?.latitude.toString() ?? ''),
            ExpandText('Longitud ', pothole?.longitude.toString() ?? ''),
            ExpandText('Dirección ', pothole?.address ?? ''),
            ExpandText('Localidad ', pothole?.locality ?? ''),
          ]),
        ),
        const GapWidget(size: 16.0),
        Text('Detalles del bache',
            style: Theme.of(context).textTheme.titleMedium),
        const GapWidget(size: 8.0),
        const ContainerFormWidget(
          child: Column(
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child:
                Text(leftText, style: Theme.of(context).textTheme.titleSmall)),
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
          Text('Foto del bache',
              style: Theme.of(context).textTheme.titleMedium),
          const GapWidget(size: 8.0),
          const ContainerFormWidget(
            child: Column(children: [
              _ImageViewer(),
              GapWidget(size: 8.0),
              Row(
                children: [
                  Expanded(child: _UploadPhotoButton()),
                  if (!kIsWeb) ...[
                    GapWidget(size: 8.0),
                    Expanded(child: _TakePhotoButton()),
                  ],
                ],
              ),
            ]),
          ),
          const GapWidget(size: 24.0),
          Text('Ubicación del bache',
              style: Theme.of(context).textTheme.titleMedium),
          const GapWidget(size: 8.0),
          const ContainerFormWidget(
            child: Column(children: [
              _LocationPickerButton(),
              GapWidget(size: 16.0),
              _LatitudeInput(),
              _LongitudeInput(),
              GapWidget(size: 8.0),
              _AddressInput(),
              GapWidget(size: 8.0),
              _LocalitySelector(),
              GapWidget(size: 4.0),
            ]),
          ),
          const GapWidget(size: 24.0),
          Text('Detalles del bache',
              style: Theme.of(context).textTheme.titleMedium),
          const GapWidget(size: 8.0),
          const ContainerFormWidget(
            child: Column(children: [
              GapWidget(size: 4.0),
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
          const ContainerFormWidget(
            child: Column(children: [
              Row(
                children: [
                  Expanded(child: _TypeSelector()),
                  // GapWidget(size: 8.0),
                  // _PredictPotholeButton(),
                ],
              ),
              // _PredictionDetails(),
            ]),
          ),
          const GapWidget(size: 16.0),
        ],
      ),
    );
  }
}

class _LocationPickerButton extends StatelessWidget {
  const _LocationPickerButton();

  void _onPressed(BuildContext context) async {
    final currentLocation = GoRouterState.of(context).matchedLocation;
    context.push('$currentLocation/${AppPaths.locationPicker}');
  }

  @override
  Widget build(BuildContext context) {
    return FilledButtonIconWidget(
      label: 'Seleccionar ubicación',
      icon: Icons.location_on,
      onPressed: () => _onPressed(context),
      color: AppColors.anakiwa,
      contentColor: AppColors.blumine,
    );
  }
}

class _AddressInput extends StatelessWidget {
  const _AddressInput();

  @override
  Widget build(BuildContext context) {
    final potholeFormController = Get.isRegistered<PotholeFormController>()
        ? Get.find<PotholeFormController>()
        : null;
    return potholeFormController == null
        ? const SizedBox()
        : SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Dirección',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => TextFieldRxWidget(
                      label: 'Dirección',
                      maxLines: 2,
                      initialValue: potholeFormController.address.value.value,
                      keyboardType: TextInputType.text,
                      onChanged: potholeFormController.onAddressChanged,
                      errorMessage: potholeFormController.isPosted
                          ? potholeFormController.address.value.errorMessage
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class _DescriptionInput extends StatelessWidget {
  const _DescriptionInput();

  @override
  Widget build(BuildContext context) {
    final potholeFormController = Get.isRegistered<PotholeFormController>()
        ? Get.find<PotholeFormController>()
        : null;
    return potholeFormController == null
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Descripción',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const GapWidget(size: 8.0),
              Obx(
                () => TextFieldRxWidget(
                  label: 'Descripción',
                  maxLines: 6,
                  initialValue: potholeFormController.description.value.value,
                  keyboardType: TextInputType.text,
                  onChanged: potholeFormController.onDescriptionChanged,
                  errorMessage: potholeFormController.isPosted
                      ? potholeFormController.description.value.errorMessage
                      : null,
                ),
              ),
            ],
          );
  }
}

class _LocalitySelector extends StatelessWidget {
  const _LocalitySelector();

  @override
  Widget build(BuildContext context) {
    final potholeFormController = Get.isRegistered<PotholeFormController>()
        ? Get.find<PotholeFormController>()
        : null;
    return potholeFormController == null
        ? const SizedBox()
        : SizedBox(
            height: 48.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Localidad',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => LocalitySelectorWidget(
                      onChanged: potholeFormController.onLocalityChanged,
                      initialValue: potholeFormController.locality.value.value,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class _TypeSelector extends GetView<PotholeController> {
  const _TypeSelector();

  @override
  Widget build(BuildContext context) {
    final potholeController = Get.isRegistered<PotholeController>()
        ? Get.find<PotholeController>()
        : null;
    return potholeController == null
        ? const SizedBox()
        : Obx(
            () => SizedBox(
              height: 48.0,
              child: SelectorWidget(
                onChanged: null,
                icon: Icons.insights,
                initialValue: controller.pothole.value?.type ?? '',
                items: PotholeConstants.types,
              ),
            ),
          );
  }
}

class _LatitudeInput extends StatelessWidget {
  const _LatitudeInput();

  @override
  Widget build(BuildContext context) {
    final potholeFormController = Get.isRegistered<PotholeFormController>()
        ? Get.find<PotholeFormController>()
        : null;
    return potholeFormController == null
        ? const SizedBox()
        : SizedBox(
            height: 32.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Latitud',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => Text(potholeFormController.latitude.value.value),
                  ),
                ),
              ],
            ),
          );
  }
}

class _LongitudeInput extends StatelessWidget {
  const _LongitudeInput();

  @override
  Widget build(BuildContext context) {
    final potholeFormController = Get.isRegistered<PotholeFormController>()
        ? Get.find<PotholeFormController>()
        : null;
    return potholeFormController == null
        ? const SizedBox()
        : SizedBox(
            height: 32.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Longitud',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => Text(potholeFormController.longitude.value.value),
                  ),
                ),
              ],
            ),
          );
  }
}

class _ImageViewer extends StatelessWidget {
  const _ImageViewer();

  @override
  Widget build(BuildContext context) {
    final potholeFormController = Get.isRegistered<PotholeFormController>()
        ? Get.find<PotholeFormController>()
        : null;
    return Center(
      child: Container(
        constraints: const BoxConstraints(minHeight: 250, maxHeight: 500),
        child: potholeFormController == null
            ? const SizedBox()
            : Obx(() => ImageViewerWidget(
                potholeFormController.image.value.value.path)),
      ),
    );
  }
}

class _PredictionDetails extends StatelessWidget {
  const _PredictionDetails();

  @override
  Widget build(BuildContext context) {
    final potholeFormController = Get.isRegistered<PotholeFormController>()
        ? Get.find<PotholeFormController>()
        : null;
    return potholeFormController == null
        ? const SizedBox()
        : Obx(
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
                  ...potholeFormController.weights.map(
                    (weight) => Text(weight.toString()),
                  ),
                ],
              );
            },
          );
  }
}

class _UploadPhotoButton extends StatelessWidget {
  const _UploadPhotoButton();

  void onPressed(PotholeFormController? potholeFormController) async {
    final photo = await CameraGalleryServiceImpl().selectPhoto();
    if (photo == null) return;
    potholeFormController?.onImageChanged(photo);
  }

  @override
  Widget build(BuildContext context) {
    final potholeFormController = Get.isRegistered<PotholeFormController>()
        ? Get.find<PotholeFormController>()
        : null;
    return FilledButtonIconWidget(
      label: 'Seleccionar foto',
      icon: Icons.photo,
      onPressed: () => onPressed(potholeFormController),
      color: AppColors.anakiwa,
      contentColor: AppColors.blumine,
    );
  }
}

class _TakePhotoButton extends StatelessWidget {
  const _TakePhotoButton();

  void onPressed(PotholeFormController? potholeFormController) async {
    final photo = await CameraGalleryServiceImpl().takePhoto();
    if (photo == null) return;

    potholeFormController?.onImageChanged(photo);
  }

  @override
  Widget build(BuildContext context) {
    final potholeFormController = Get.isRegistered<PotholeFormController>()
        ? Get.find<PotholeFormController>()
        : null;
    return SizedBox(
      height: 48,
      child: OutlinedButtonIconWidget(
        onPressed: () => onPressed(potholeFormController),
        label: 'Tomar foto',
        icon: const Icon(Icons.camera_alt, color: Color(0xFF3D5D67)),
      ),
    );
  }
}

class _PredictPotholeButton extends StatelessWidget {
  const _PredictPotholeButton();

  @override
  Widget build(BuildContext context) {
    final potholeFormController = Get.isRegistered<PotholeFormController>()
        ? Get.find<PotholeFormController>()
        : null;
    return SizedBox(
      width: 140,
      child: OutlinedButtonIconWidget(
        onPressed: potholeFormController?.onPredict,
        label: 'Predecir',
        icon: const Icon(Icons.insights, color: Colors.white),
      ),
    );
  }
}

// class _SubmitButton extends StatelessWidget {
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
