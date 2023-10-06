import 'package:flutter/material.dart';

class CustomToggleButton extends StatefulWidget {
  final List<Widget> options;
  final List<bool> isSelected;
  final bool vertical;
  final bool isRadius;
  final double minHeight;
  final double minWidth;
  final Function(int index) onPressed;

  CustomToggleButton({
    Key? key,
    required this.options,
    required this.isSelected,
    this.vertical = false,
    this.isRadius = true,
    double? minHeight,
    double? minWidth,
    required this.onPressed,
  })  : minHeight = minHeight ?? 50.0,
        minWidth = minWidth ?? 65.0,
        super(key: key);

  @override
  State<CustomToggleButton> createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        ToggleButtons(
          direction: widget.vertical ? Axis.vertical : Axis.horizontal,
          onPressed: widget.onPressed,
          borderRadius: widget.isRadius ? const BorderRadius.all(Radius.circular(8)) : null,
          borderWidth: 1.5,
          // 전체적인 경계 색
          borderColor: Colors.grey[400],
          // 선택 요소의 경계 색
          selectedBorderColor: Colors.black,
          // 선택 요소의 글자 색
          selectedColor: Colors.black,
          // 선택 요소의 배경 색
          fillColor: Colors.white,
          // 비 선택 요소의 글자 색
          color: Colors.black,
          disabledColor: Colors.red,
          splashColor: Colors.grey[300],
          constraints: BoxConstraints(
            minHeight: widget.minHeight,
            minWidth: widget.minWidth,
          ),
          isSelected: widget.isSelected,
          children: widget.options,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
