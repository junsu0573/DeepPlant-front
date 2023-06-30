import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backButton;
  final bool closeButton;
  final VoidCallback? backButtonOnPressed;
  final VoidCallback? closeButtonOnPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.backButton,
    required this.closeButton,
    this.backButtonOnPressed,
    this.closeButtonOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: backButton,
      foregroundColor: Colors.black,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 36.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: closeButton
          ? [
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: closeButtonOnPressed ??
                    () {
                      context.pop();
                    },
              ),
            ]
          : null,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
