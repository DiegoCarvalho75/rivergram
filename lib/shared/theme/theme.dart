import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

const Color primaryColor = Colors.teal;
final String? mainFontFamily = GoogleFonts.montserrat().fontFamily;
final String? buttonFontFamily = GoogleFonts.aclonica().fontFamily;
final String? headlineFontFamily = GoogleFonts.pacifico().fontFamily;
final TextTheme darkTextTheme = ThemeData.dark().textTheme;
// final ThemeData customTheme = ThemeData.dark().copyWith(
//   colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
//   scaffoldBackgroundColor: Colors.black.withOpacity(0.9),
//   inputDecorationTheme: InputDecorationTheme(
//     filled: true,
//     border: OutlineInputBorder(),
//   ),
//   textTheme: darkTextTheme
//       .apply(
//         fontFamily: mainFontFamily,
//       )
//       .copyWith(
//         headline1: ThemeData.dark()
//             .textTheme
//             .headline1
//             ?.apply(fontFamily: headlineFontFamily),
//         headline2: ThemeData.dark()
//             .textTheme
//             .headline2
//             ?.apply(fontFamily: headlineFontFamily),
//         headline3: ThemeData.dark()
//             .textTheme
//             .headline3
//             ?.apply(fontFamily: headlineFontFamily),
//       ),
//   outlinedButtonTheme: OutlinedButtonThemeData(
//     style: OutlinedButton.styleFrom(
//         side: const BorderSide(
//           width: 1,
//           color: Colors.red,
//         ),
//         padding: const EdgeInsets.all(16),
//         foregroundColor: Colors.red,
//         textStyle: TextStyle(fontSize: 18, fontFamily: buttonFontFamily)),
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//         side: const BorderSide(
//           width: 1,
//           color: primaryColor,
//         ),
//         padding: const EdgeInsets.all(16),
//         textStyle: TextStyle(fontSize: 18, fontFamily: buttonFontFamily)),
//   ),
// );
final customTheme = FlexThemeData.dark(
  fontFamily: mainFontFamily,
  blendLevel: 10,
  // surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
  useMaterial3: true,
  scheme: FlexScheme.blumineBlue,
  appBarOpacity: 0.3,
  subThemesData: const FlexSubThemesData(
    elevatedButtonSchemeColor: SchemeColor.secondary,
  ),
);

final customTextTheme = customTheme.textTheme.copyWith(
  headlineMedium: customTheme.textTheme.headlineMedium?.copyWith(
    fontFamily: headlineFontFamily,
    color: customTheme.colorScheme.primary,
  ),
);
