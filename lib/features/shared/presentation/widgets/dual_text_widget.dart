import 'package:flutter/material.dart';

class DualTextWidget extends StatelessWidget {
  const DualTextWidget({
    required this.leftText,
    required this.rightText,
    this.leftTextStyle,
    this.rightTextStyle,
    super.key,
  });

  final String leftText;
  final String rightText;
  final TextStyle? leftTextStyle;
  final TextStyle? rightTextStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            leftText,
            style: leftTextStyle ?? Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Expanded(
          child: Text(
            rightText,
            style: rightTextStyle,
          ),
        ),
      ],
    );
  }
}