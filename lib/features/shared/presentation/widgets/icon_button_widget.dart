import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData icon;

  const IconButtonWidget({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: onPressed,
        label: Text(label),
        icon: Icon(icon),
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
      ),
    );
  }
}
