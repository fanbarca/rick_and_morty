import 'package:flutter/material.dart';

class ShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedTop(),
      child: Container(
        height: 1300,
        color: Colors.red.withOpacity(0.8),
      ),
    );
  }
}

class CurvedTop extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = 30;
    Path path = Path();
    path.lineTo(0.0, height);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, height);

    path.quadraticBezierTo(
        size.width - (size.width / 4), 0.0, size.width / 2, 0.0);
    path.quadraticBezierTo(size.width / 4, 0.0, 0.0, height);
    path.lineTo(0.0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
