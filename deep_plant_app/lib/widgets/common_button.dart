import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final Widget text;
  final void Function()? onPress;
  final double width;
  final double height;
  final Color? bgColor;
  final Color? fgColor;
  CommonButton({
    super.key,
    required this.text,
    required this.onPress,
    required this.width,
    required this.height,
    this.bgColor,
    this.fgColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: fgColor,
          backgroundColor: bgColor ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: fgColor != null
                ? BorderSide(color: Colors.black)
                : BorderSide.none,
          ),
        ),
        child: text,
      ),
    );
  }
}
