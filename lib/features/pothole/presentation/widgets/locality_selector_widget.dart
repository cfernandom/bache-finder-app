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

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Obx(() {
        return DropdownButton<String>(
          hint: Text('Selecciona una localidad', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xFFBDBDBD))),
          dropdownColor: const Color(0xFFFFFFFF),
          isExpanded: true,
          value: controller.selectedLocality.value,
          underline: const SizedBox.shrink(),
          items: Locations.bogotaLocalities.map((String locality) {
            return DropdownMenuItem<String>(
              value: locality,
              child: Text(locality, style: Theme.of(context).textTheme.bodyMedium),
            );
          }).toList(),
          onChanged: (newValue) {
            controller.updateLocality(newValue);
            onChanged(newValue);
          },
        );
      }),
    );
  }
}

class LocalitySelectorController extends GetxController {
  var selectedLocality = Rxn<String>();

  void updateLocality(String? newLocality) {
    selectedLocality.value = newLocality;
  }
}
