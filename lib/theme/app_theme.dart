import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Fridgenius neo-brutalism design system.
///
/// This file is the SINGLE SOURCE OF TRUTH for colors, borders, shadows,
/// radii and typography. Every screen and reusable widget must consume tokens
/// from here — no inline one-off colors, borders, or shadows anywhere else.

/// Color tokens.
abstract class AppColors {
  static const Color cream = Color(0xFFFFF9E8); // background
  static const Color coral = Color(0xFFFF6B4A); // primary
  static const Color gold = Color(0xFFFFC93C); // secondary / highlight
  static const Color black = Color(0xFF000000); // outlines + text
  static const Color white = Color(0xFFFFFFFF);

  /// Subtle green used by the dotted background painter (alpha baked in).
  static const Color dot = Color(0x333BA55D);

  /// Extra accent used only for image/placeholder blocks (kept in-system).
  static const Color mint = Color(0xFF9BE7C4);
}

/// Border tokens — 3px solid black on every card, button, input and pill.
abstract class AppBorders {
  static const double width = 3.0;
  static const BorderSide side = BorderSide(color: AppColors.black, width: width);
  static Border get all => Border.all(color: AppColors.black, width: width);
}

/// Corner radius tokens (cards 16, buttons/inputs 12, pills fully rounded).
abstract class AppRadii {
  static const double card = 16.0;
  static const double button = 12.0;
  static const BorderRadius cardRadius =
      BorderRadius.all(Radius.circular(card));
  static const BorderRadius buttonRadius =
      BorderRadius.all(Radius.circular(button));
  static const BorderRadius pill = BorderRadius.all(Radius.circular(999));
}

/// Hard offset drop-shadow tokens — 5px 5px 0px black, NO blur.
abstract class AppShadows {
  static const Offset offset = Offset(5, 5);
  static const List<BoxShadow> hard = [
    BoxShadow(color: AppColors.black, offset: offset, blurRadius: 0),
  ];

  /// Empty shadow list used for the "pressed into shadow" state.
  static const List<BoxShadow> none = <BoxShadow>[];
}

/// Typography tokens. Display font = Archivo Black, body font = Inter.
abstract class AppText {
  static TextStyle get display =>
      GoogleFonts.archivoBlack(fontSize: 34, height: 1.02, color: AppColors.black);
  static TextStyle get title =>
      GoogleFonts.archivoBlack(fontSize: 22, color: AppColors.black);
  static TextStyle get heading =>
      GoogleFonts.archivoBlack(fontSize: 18, color: AppColors.black);
  static TextStyle get button => GoogleFonts.archivoBlack(
      fontSize: 16, letterSpacing: 0.4, color: AppColors.black);
  static TextStyle get body =>
      GoogleFonts.inter(fontSize: 15, height: 1.4, color: AppColors.black);
  static TextStyle get bodyBold => GoogleFonts.inter(
      fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.black);
  static TextStyle get caption =>
      GoogleFonts.inter(fontSize: 13, color: AppColors.black);
  static TextStyle get pill => GoogleFonts.inter(
      fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.black);
}

/// Assembled [ThemeData] every screen consumes via MaterialApp.
abstract class AppTheme {
  static ThemeData get light {
    final base = ThemeData(useMaterial3: true, brightness: Brightness.light);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.cream,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.coral,
        onPrimary: AppColors.black,
        secondary: AppColors.gold,
        onSecondary: AppColors.black,
        surface: AppColors.white,
        onSurface: AppColors.black,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme)
          .apply(bodyColor: AppColors.black, displayColor: AppColors.black),
      iconTheme: const IconThemeData(color: AppColors.black),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
    );
  }
}
