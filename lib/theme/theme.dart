import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006b5e),
      surfaceTint: Color(0xff006b5e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9ff2e2),
      onPrimaryContainer: Color(0xff005047),
      secondary: Color(0xff4a635e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcde8e1),
      onSecondaryContainer: Color(0xff334b46),
      tertiary: Color(0xff446179),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffcae6ff),
      onTertiaryContainer: Color(0xff2c4a60),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff4fbf8),
      onSurface: Color(0xff171d1b),
      onSurfaceVariant: Color(0xff3f4946),
      outline: Color(0xff6f7976),
      outlineVariant: Color(0xffbec9c5),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3230),
      inversePrimary: Color(0xff83d5c6),
      primaryFixed: Color(0xff9ff2e2),
      onPrimaryFixed: Color(0xff00201b),
      primaryFixedDim: Color(0xff83d5c6),
      onPrimaryFixedVariant: Color(0xff005047),
      secondaryFixed: Color(0xffcde8e1),
      onSecondaryFixed: Color(0xff06201b),
      secondaryFixedDim: Color(0xffb1ccc5),
      onSecondaryFixedVariant: Color(0xff334b46),
      tertiaryFixed: Color(0xffcae6ff),
      onTertiaryFixed: Color(0xff001e30),
      tertiaryFixedDim: Color(0xffaccae5),
      onTertiaryFixedVariant: Color(0xff2c4a60),
      surfaceDim: Color(0xffd5dbd9),
      surfaceBright: Color(0xfff4fbf8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f2),
      surfaceContainer: Color(0xffe9efec),
      surfaceContainerHigh: Color(0xffe3eae7),
      surfaceContainerHighest: Color(0xffdde4e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff83d5c6),
      surfaceTint: Color(0xff83d5c6),
      onPrimary: Color(0xff003730),
      primaryContainer: Color(0xff005047),
      onPrimaryContainer: Color(0xff9ff2e2),
      secondary: Color(0xffb1ccc5),
      onSecondary: Color(0xff1c3530),
      secondaryContainer: Color(0xff334b46),
      onSecondaryContainer: Color(0xffcde8e1),
      tertiary: Color(0xffaccae5),
      onTertiary: Color(0xff133348),
      tertiaryContainer: Color(0xff2c4a60),
      onTertiaryContainer: Color(0xffcae6ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1513),
      onSurface: Color(0xffdde4e1),
      onSurfaceVariant: Color(0xffbec9c5),
      outline: Color(0xff899390),
      outlineVariant: Color(0xff3f4946),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e1),
      inversePrimary: Color(0xff006b5e),
      primaryFixed: Color(0xff9ff2e2),
      onPrimaryFixed: Color(0xff00201b),
      primaryFixedDim: Color(0xff83d5c6),
      onPrimaryFixedVariant: Color(0xff005047),
      secondaryFixed: Color(0xffcde8e1),
      onSecondaryFixed: Color(0xff06201b),
      secondaryFixedDim: Color(0xffb1ccc5),
      onSecondaryFixedVariant: Color(0xff334b46),
      tertiaryFixed: Color(0xffcae6ff),
      onTertiaryFixed: Color(0xff001e30),
      tertiaryFixedDim: Color(0xffaccae5),
      onTertiaryFixedVariant: Color(0xff2c4a60),
      surfaceDim: Color(0xff0e1513),
      surfaceBright: Color(0xff343b39),
      surfaceContainerLowest: Color(0xff090f0e),
      surfaceContainerLow: Color(0xff171d1b),
      surfaceContainer: Color(0xff1b211f),
      surfaceContainerHigh: Color(0xff252b2a),
      surfaceContainerHighest: Color(0xff303634),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.background,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
