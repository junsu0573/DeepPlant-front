//

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EvalButton extends StatelessWidget {
  final bool isSelected;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const EvalButton({
    super.key,
    required this.isSelected,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 106.w,
      height: 106.h,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 2,
          ),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        onPressed: onPressed,
        child: Container(),
      ),
    );
  }
}

class EvalRow extends StatefulWidget {
  final List<bool> isSelected;
  final Function(int) onEvalButtonPressed;
  final List<String> text;

  const EvalRow({
    super.key,
    required this.isSelected,
    required this.onEvalButtonPressed,
    required this.text,
  });

  @override
  _EvalRowState createState() => _EvalRowState();
}

class _EvalRowState extends State<EvalRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.text.length; i++)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.5.w),
                child: EvalButton(
                  isSelected: widget.isSelected[i],
                  backgroundColor: [
                    Color(0xFFEFEFEF),
                    Color(0xFFD9D9D9),
                    Color(0xFFB0B0B0),
                    Color(0xFF6F6F6F),
                    Color(0xFF363636),
                  ][i],
                  onPressed: () => widget.onEvalButtonPressed(i),
                ),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.text.length; i++)
              SizedBox(
                width: 123.w,
                child: Text(
                  widget.text[i],
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
