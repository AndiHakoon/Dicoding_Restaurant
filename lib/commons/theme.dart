import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFFFFFFF);
const Color primaryLightColor = Color(0xFFFFFFFF);
const Color primaryDarkColor = Color(0xFF585858);
const Color secondaryColor = Color(0xFFF34040);
const Color secondaryLightColor = Color(0xFFE07265);
const Color secondaryDarkColor = Color(0xFFBA0E27);
const Color primaryTextColor = Color(0xFF3E6ED0);
const Color secondaryTextColor = Color(0xFF000000);

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.poppins(
      fontSize: 93, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.poppins(
      fontSize: 58, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.poppins(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.poppins(
      fontSize: 33, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.poppins(
      fontSize: 23, fontWeight: FontWeight.bold, color: secondaryColor),
  headline6: GoogleFonts.poppins(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.poppins(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  appBarTheme: AppBarTheme(
    elevation: 0, toolbarTextStyle: myTextTheme.apply(bodyColor: primaryTextColor).bodyText2, titleTextStyle: myTextTheme.apply(bodyColor: primaryTextColor).headline6,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: secondaryColor,
    unselectedItemColor: Colors.black54,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: secondaryColor,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
  chipTheme: const ChipThemeData(
    labelStyle: TextStyle(
      color: secondaryColor,
    ),
    selectedColor: secondaryColor,
    disabledColor: primaryDarkColor,
    selectedShadowColor: Color(0xFF616161),
    secondarySelectedColor: secondaryColor,
    secondaryLabelStyle: TextStyle(
      color: primaryColor,
    ),
    brightness: Brightness.light,
    backgroundColor: Color(0xFFFFE9E9),
    padding: EdgeInsets.all(2),
  ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: secondaryColor),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: primaryDarkColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  appBarTheme: AppBarTheme(
    elevation: 0, toolbarTextStyle: myTextTheme.apply(bodyColor: Colors.white).bodyText2, titleTextStyle: myTextTheme.apply(bodyColor: Colors.white).headline6,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: secondaryColor,
    unselectedItemColor: Colors.blueGrey,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: secondaryColor,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: secondaryDarkColor),
);
