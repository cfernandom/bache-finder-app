import 'package:flutter/material.dart';

class GapWidget extends StatelessWidget {
  final double size;
  const GapWidget({super.key, this.size = 8.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
    );
  }
}
