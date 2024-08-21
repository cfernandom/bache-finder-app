import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectorWidget extends StatelessWidget {
  final void Function(String) onChanged;
  final String initialValue;
  final List<String> items;

  const SelectorWidget({
    super.key,
    required this.onChanged,
    required this.initialValue,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectorController());
    
    controller.selectedValue.value = initialValue;

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Obx(() {
        return DropdownButton<String>(
          hint: const Text('Selecciona una opción'),
          dropdownColor: const Color(0xFFFFFFFF),
          value: controller.selectedValue.value,
          isExpanded: true,
          underline: const SizedBox.shrink(),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: Theme.of(context).textTheme.bodyMedium),
            );
          }).toList(),
          onChanged: (newValue) {
            controller.updateValue(newValue ?? items.first);
            onChanged(newValue ?? items.first);
          },
        );
      }),
    );
  }
}

class SelectorController extends GetxController {
  var selectedValue = Rxn<String>();

  void updateValue(String newValue) {
    selectedValue.value = newValue;
  }
}