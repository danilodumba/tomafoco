import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData defaultTheme() {
  return ThemeData(
    // Define the default brightness and colors.
    //brightness: brightness,
    primaryColor: LightColors.primaryColor,
    backgroundColor: LightColors.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: LightColors.kLightYellow,
      centerTitle: true,
    ),

    fontFamily: "Poppins",
    //  textTheme: TextTheme(
    //  overline: TextStyle(
    //     fontFamily: "Poppins",
    //  ),
    //   subtitle1: TextStyle(
    //     fontFamily: "Poppins",
    //   ),
    //   subtitle2: TextStyle(
    //     fontFamily: "Poppins",
    //   ),
    //   headline6: TextStyle(
    //     fontFamily: "Poppins",
    //   ),
    //   bodyText1: TextStyle(
    //     color: Color(0xFF464e5f),
    //     fontFamily: "Poppins",
    //   ),
    //   bodyText2: TextStyle(
    //     fontSize: 12,
    //     fontFamily: "Poppins",
    //   ),
    //   headline1: TextStyle(
    //     fontSize: 26,
    //     fontWeight: FontWeight.bold,
    //     fontFamily: "Poppins",
    //   ),
    //   headline2: TextStyle(
    //     fontSize: 18,
    //     color: Color(0xFF212121),
    //     fontWeight: FontWeight.bold,
    //     fontFamily: "Poppins",
    //   ),
    //   headline3: TextStyle(
    //     fontSize: 16,
    //     fontWeight: FontWeight.bold,
    //     fontFamily: "Poppins",
    //   ),
    //   headline4: TextStyle(
    //     fontFamily: "Poppins",
    //   ),

    //   caption: TextStyle(
    //     fontFamily: "Poppins",
    //   ),

    //   button: TextStyle(
    //     color: ligthColor,
    //     fontFamily: "Poppins",
    //   ),
    //   // headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    //   // headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    //   // bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    // ),
  );
}
