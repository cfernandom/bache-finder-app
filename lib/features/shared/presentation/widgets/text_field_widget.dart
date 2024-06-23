import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key, 
    required this.label,
    this.initialValue = '',
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
    this.errorMessage,
    this.onChanged,
    this.prefix = '',
    this.suffix = '',
  });

  final String label;
  final String initialValue;
  final bool isObscure;
  final TextInputType keyboardType;
  final String? errorMessage;
  final void Function(String)? onChanged;
  final String prefix;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: isObscure,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixText: prefix,
        suffixText: suffix,
        errorText: errorMessage,
      ),
    );
  }
}
