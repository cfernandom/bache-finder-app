import 'package:bache_finder_app/core/constants/locations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalitySelectorWidget extends StatelessWidget {
  final void Function(String?) onChanged;
  final String? initialValue;

  const LocalitySelectorWidget({
    super.key,
    required this.onChanged,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final LocalitySelectorController controller =
        Get.put(LocalitySelectorController());

    controller.selectedLocality.value = initialValue;

    return Obx(() {
      return DropdownButton<String>(
        hint: const Text('Selecciona una localidad'),
        value: controller.selectedLocality.value,
        items: Locations.bogotaLocalities.map((String locality) {
          return DropdownMenuItem<String>(
            value: locality,
            child: Text(locality),
          );
        }).toList(),
        onChanged: (newValue) {
          controller.updateLocality(newValue);
          onChanged(newValue);
        },
      );
    });
  }
}

class LocalitySelectorController extends GetxController {
  var selectedLocality = Rxn<String>();

  void updateLocality(String? newLocality) {
    selectedLocality.value = newLocality;
  }
}
