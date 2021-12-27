import 'package:flutter/material.dart';

class ConstContainer extends StatelessWidget {
  final Color containerColor;
  final String label;
  final Color textColor;

  // ignore: use_key_in_widget_constructors
  const ConstContainer({required this.containerColor, required this.label,required this.textColor});
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin:const EdgeInsets.symmetric(horizontal: 10.0),
      height:50.0,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: containerColor,
      ),
      child: Center(
          child: Text(
              label,
              style: TextStyle(color:textColor))),
    );
  }
}