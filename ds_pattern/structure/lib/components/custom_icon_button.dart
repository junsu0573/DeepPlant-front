import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final ImageProvider image;
  final VoidCallback onTap;
  final double width;
  final double height;

  const CustomIconButton({
    super.key,
    required this.image,
    required this.onTap,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: SizedBox(
          width: width,
          height: height,
          child: Image(
            image: image,
          ),
        ),
      ),
    );
  }
}
