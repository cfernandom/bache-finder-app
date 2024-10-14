import 'package:bache_finder_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class FilledButtonIconWidget extends StatelessWidget {
  const FilledButtonIconWidget({
    super.key,
    this.onPressed,
    required this.label,
    required this.icon,
    this.color = AppColors.blumine,
    this.contentColor = Colors.white,
  });

  final VoidCallback? onPressed;
  final String label;
  final Color color;
  final IconData icon;
  final Color contentColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.0,
      child: FilledButton.icon(
          onPressed: onPressed,
          label: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: contentColor),
          ),
          icon: Icon(icon, color: contentColor),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(color),
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          )),
    );
  }
}
