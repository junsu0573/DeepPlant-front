import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NonformTextField extends StatelessWidget {
  final TextStyle textStyle;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final FocusNode? focusNode;
  final String? hintText;
  final Color? labelColor;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  const NonformTextField({
    super.key,
    required this.textStyle,
    this.inputFormatters,
    required this.textEditingController,
    required this.textInputType,
    this.focusNode,
    this.hintText,
    this.labelColor,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.end,
      style: textStyle,
      inputFormatters: inputFormatters,
      controller: textEditingController,
      showCursor: false,
      keyboardType: textInputType,
      focusNode: focusNode,
      autofocus: false,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 10.0),
        filled: true,
        fillColor: Colors.grey[100],
        hintText: hintText,
        labelStyle: TextStyle(color: labelColor),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 0.2, color: Colors.grey)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 0.2, color: Colors.grey)),
        border: const UnderlineInputBorder(
            borderSide: BorderSide(width: 0.2, color: Colors.grey)),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
