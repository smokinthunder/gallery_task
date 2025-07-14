import 'package:flutter/material.dart';

class CurvedShareBar extends StatelessWidget {
  const CurvedShareBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      child: Stack(
        children: [
          Positioned(top: 30, left: 70, child: ColorProfile(Colors.pink)),

          Positioned(top: 8, left: 120, child: ColorProfile(Colors.blue)),

          Positioned(top: 0, left: 170, child: ColorProfile(Colors.orange)),

          Positioned(top: 8, left: 220, child: ColorProfile(Colors.green)),

          Positioned(top: 30, left: 270, child: ColorProfile(Colors.purple)),
        ],
      ),
    );
  }
}

class ColorProfile extends StatelessWidget {
  final Color color;

  const ColorProfile(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    const double size = 50;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(Icons.person, color: Colors.white, size: size * 0.6),
    );
  }
}
