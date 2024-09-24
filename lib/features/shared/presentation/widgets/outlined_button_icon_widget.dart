import 'package:flutter/material.dart';

class OutlinedButtonIconWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;

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
      child: FilledButton.icon(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(const Color(0xFFB9E1F2)),
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        label: Text(label, style: Theme.of(context).textTheme.titleSmall!.copyWith(color: const Color(0xFF3D5D67))),
        icon: icon,
      ),
    );
  }
}
