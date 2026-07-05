import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Fridgenius neo-brutalism design system.
///
/// This file is the SINGLE SOURCE OF TRUTH for colors, borders, shadows,
/// radii and typography. Every screen and reusable widget must consume tokens
/// from here — no inline one-off colors, borders, or shadows anywhere else.

/// Color tokens — "Ocean Cool" palette (teal / sky / mist / ink).
///
/// The token NAMES are kept stable (so every screen keeps compiling), but the
/// VALUES define the current palette. Read them semantically:
///   cream = background · coral = primary · gold = secondary/highlight ·
///   black = ink (text + outlines) · mint = soft accent · alert = warnings.
abstract class AppColors {
  static const Color cream = Color(0xFFF0FBFA); // background (mist)
  static const Color coral = Color(0xFF12B0A0); // primary (teal)
  static const Color gold = Color(0xFF4CC9F0); // secondary / highlight (sky)
  static const Color black = Color(0xFF08312D); // outlines + text (ink)
  static const Color white = Color(0xFFFFFFFF);

  /// Warm attention color for "missing item" badges — pops against the
  /// cool palette without reintroducing a full second brand color.
  static const Color alert = Color(0xFFFF9F1C);

  /// Subtle teal used by the dotted background painter (alpha baked in).
  static const Color dot = Color(0x2612B0A0);

  /// Extra accent used for image/placeholder blocks (kept in-system).
  static const Color mint = Color(0xFF9BE7D4);

  /// Purple used for the header avatar chip.
  static const Color avatar = Color(0xFF9B5DE5);

  /// Vivid tile palette — recipe tiles cycle through these bold colors for the
  /// colorful grid look. App chrome (buttons, nav, background) stays teal/sky.
  static const List<Color> tileColors = [
    Color(0xFFFB5A72), // pink
    Color(0xFFFFC93C), // yellow
    Color(0xFF35C46A), // green
    Color(0xFF4C8DFF), // blue
    Color(0xFF12B0A0), // teal
    Color(0xFF9B5DE5), // purple
  ];

  /// Picks black or white ink for legible text on top of [c].
  static Color inkOn(Color c) =>
      c.computeLuminance() > 0.45 ? black : white;
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

/// Typography tokens. Display/headings = Archivo Black (chunky), everything
/// else = Space Mono (monospace labels, pills, body, nav) to match the
/// reference UI.
abstract class AppText {
  static TextStyle get display => GoogleFonts.archivoBlack(
      fontSize: 30, height: 1.02, letterSpacing: -0.5, color: AppColors.black);
  static TextStyle get title =>
      GoogleFonts.archivoBlack(fontSize: 22, color: AppColors.black);
  static TextStyle get heading =>
      GoogleFonts.archivoBlack(fontSize: 17, height: 1.05, color: AppColors.black);
  static TextStyle get button => GoogleFonts.spaceMono(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      color: AppColors.black);
  static TextStyle get body =>
      GoogleFonts.spaceMono(fontSize: 14, height: 1.45, color: AppColors.black);
  static TextStyle get bodyBold => GoogleFonts.spaceMono(
      fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.black);
  static TextStyle get caption =>
      GoogleFonts.spaceMono(fontSize: 12.5, color: AppColors.black);
  static TextStyle get pill => GoogleFonts.spaceMono(
      fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.black);
  static TextStyle get navLabel => GoogleFonts.spaceMono(
      fontSize: 10.5, fontWeight: FontWeight.w700, letterSpacing: 0.3,
      color: AppColors.black);
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
      textTheme: GoogleFonts.spaceMonoTextTheme(base.textTheme)
          .apply(bodyColor: AppColors.black, displayColor: AppColors.black),
      iconTheme: const IconThemeData(color: AppColors.black),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
    );
  }
}
