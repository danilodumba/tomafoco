import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BuletWidget extends StatelessWidget {
  Color backgroundColor;
  Color labelColor;
  String label = "";

  BuletWidget({
    Key? key,
    this.backgroundColor = Colors.white,
    this.labelColor = Colors.black,
    this.label = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: 40,
      height: 40,
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: const CircleBorder(),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
