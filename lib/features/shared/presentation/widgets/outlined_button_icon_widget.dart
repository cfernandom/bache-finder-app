import 'package:flutter/material.dart';

class OutlinedButtonIconWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData icon;

  const OutlinedButtonIconWidget({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
        label: Text(label),
        icon: Icon(icon),
      ),
    );
  }
}
