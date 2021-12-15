import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonCircularWidget extends StatelessWidget {
  String? tooltip;
  Color? buttonColor;
  Color? backgroundColor;
  IconData icon;
  VoidCallback? onPress;

  ButtonCircularWidget({
    Key? key,
    this.tooltip,
    this.buttonColor = Colors.white,
    this.backgroundColor = Colors.black,
    this.icon = Icons.access_alarm,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: const CircleBorder(),
      ),
      child: IconButton(
        onPressed: onPress,
        icon: Icon(icon),
        tooltip: tooltip,
        color: buttonColor,
        splashColor: Colors.white,
        highlightColor: Colors.white,
      ),
    );
  }
}
