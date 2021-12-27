import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.all(20.0),
      height: 85.0,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:AssetImage('images/BreakingBadLogo.png'),
          fit: BoxFit.contain,
        ),
        boxShadow: [BoxShadow(
          color: Colors.black12,
          spreadRadius: 3,
          blurRadius: 9,
          offset: Offset(0,3),
        )],
        shape: BoxShape.circle,
      ),
    );
  }
}
