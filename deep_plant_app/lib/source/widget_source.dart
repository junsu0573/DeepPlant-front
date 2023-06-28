import 'package:flutter/material.dart';

class elevated extends StatelessWidget {
  elevated({
    Key? key,
    required this.icon,
    required this.colorb,
    required this.colori,
    this.size,
  }) : super(key: key);

  final IconData? icon;
  final Color? colorb;
  final Color? colori;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: colorb!,
        elevation: 0.0,
      ),
      child: Icon(
        icon!,
        color: colori!,
        size: size,
      ),
    );
  }
}
