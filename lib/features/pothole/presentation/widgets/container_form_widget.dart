import 'package:bache_finder_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ContainerFormWidget extends StatelessWidget {
  const ContainerFormWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.aquaSqueeze,
      ),
      child: child,
    );
  }
}
