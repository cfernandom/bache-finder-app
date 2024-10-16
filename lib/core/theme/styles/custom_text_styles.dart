import 'package:flutter/material.dart';

class CustomTextStyles {
  static TextStyle getAppBarTitle(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white);
}
