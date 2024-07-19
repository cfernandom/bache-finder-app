import 'package:flutter/material.dart';

class TextFieldRxWidget extends StatefulWidget {
  const TextFieldRxWidget({
    super.key, 
    required this.label,
    this.initialValue = '',
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
    this.errorMessage,
    this.onChanged,
    this.prefix = '',
    this.suffix = '',
    this.maxLines = 1,
  });

  final String label;
  final String initialValue;
  final bool isObscure;
  final TextInputType keyboardType;
  final String? errorMessage;
  final void Function(String)? onChanged;
  final String prefix;
  final String suffix;
  final int maxLines;

  @override
  State<TextFieldRxWidget> createState() => _TextFieldRxWidgetState();
}

class _TextFieldRxWidgetState extends State<TextFieldRxWidget> {
  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.initialValue;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TextFieldRxWidget oldWidget) {
    _controller.text = widget.initialValue;
    super.didUpdateWidget(oldWidget);
  }

   @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      minLines: 1,
      controller: _controller,
      obscureText: widget.isObscure,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixText: widget.prefix,
        suffixText: widget.suffix,
        errorText: widget.errorMessage,
      ),
    );
  }
}
