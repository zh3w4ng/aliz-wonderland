import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff116b56),
      surfaceTint: Color(0xff116b56),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffa3f2d8),
      onPrimaryContainer: Color(0xff002018),
      secondary: Color(0xff4b635b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcee9dd),
      onSecondaryContainer: Color(0xff072019),
      tertiary: Color(0xff416276),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffc4e7ff),
      onTertiaryContainer: Color(0xff001e2c),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff5fbf6),
      onBackground: Color(0xff171d1a),
      surface: Color(0xfff5fbf6),
      onSurface: Color(0xff171d1a),
      surfaceVariant: Color(0xffdbe5df),
      onSurfaceVariant: Color(0xff3f4945),
      outline: Color(0xff6f7975),
      outlineVariant: Color(0xffbfc9c3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b322f),
      inverseOnSurface: Color(0xffecf2ee),
      inversePrimary: Color(0xff87d6bc),
      primaryFixed: Color(0xffa3f2d8),
      onPrimaryFixed: Color(0xff002018),
      primaryFixedDim: Color(0xff87d6bc),
      onPrimaryFixedVariant: Color(0xff005140),
      secondaryFixed: Color(0xffcee9dd),
      onSecondaryFixed: Color(0xff072019),
      secondaryFixedDim: Color(0xffb2ccc1),
      onSecondaryFixedVariant: Color(0xff344c43),
      tertiaryFixed: Color(0xffc4e7ff),
      onTertiaryFixed: Color(0xff001e2c),
      tertiaryFixedDim: Color(0xffa8cbe2),
      onTertiaryFixedVariant: Color(0xff284b5e),
      surfaceDim: Color(0xffd5dbd7),
      surfaceBright: Color(0xfff5fbf6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f1),
      surfaceContainer: Color(0xffe9efeb),
      surfaceContainerHigh: Color(0xffe3eae5),
      surfaceContainerHighest: Color(0xffdee4e0),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff004c3c),
      surfaceTint: Color(0xff116b56),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff31826c),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff30483f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff617a71),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff244759),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff57798d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff5fbf6),
      onBackground: Color(0xff171d1a),
      surface: Color(0xfff5fbf6),
      onSurface: Color(0xff171d1a),
      surfaceVariant: Color(0xffdbe5df),
      onSurfaceVariant: Color(0xff3b4541),
      outline: Color(0xff58615d),
      outlineVariant: Color(0xff737d78),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b322f),
      inverseOnSurface: Color(0xffecf2ee),
      inversePrimary: Color(0xff87d6bc),
      primaryFixed: Color(0xff31826c),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff0c6854),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff617a71),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff496158),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff57798d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff3e6074),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbd7),
      surfaceBright: Color(0xfff5fbf6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f1),
      surfaceContainer: Color(0xffe9efeb),
      surfaceContainerHigh: Color(0xffe3eae5),
      surfaceContainerHighest: Color(0xffdee4e0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff00281e),
      surfaceTint: Color(0xff116b56),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004c3c),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0f261f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff30483f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002536),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff244759),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff5fbf6),
      onBackground: Color(0xff171d1a),
      surface: Color(0xfff5fbf6),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdbe5df),
      onSurfaceVariant: Color(0xff1d2622),
      outline: Color(0xff3b4541),
      outlineVariant: Color(0xff3b4541),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b322f),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffacfce1),
      primaryFixed: Color(0xff004c3c),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003428),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff30483f),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1a312a),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff244759),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff083042),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbd7),
      surfaceBright: Color(0xfff5fbf6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f1),
      surfaceContainer: Color(0xffe9efeb),
      surfaceContainerHigh: Color(0xffe3eae5),
      surfaceContainerHighest: Color(0xffdee4e0),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff87d6bc),
      surfaceTint: Color(0xff87d6bc),
      onPrimary: Color(0xff00382b),
      primaryContainer: Color(0xff005140),
      onPrimaryContainer: Color(0xffa3f2d8),
      secondary: Color(0xffb2ccc1),
      onSecondary: Color(0xff1d352d),
      secondaryContainer: Color(0xff344c43),
      onSecondaryContainer: Color(0xffcee9dd),
      tertiary: Color(0xffa8cbe2),
      onTertiary: Color(0xff0d3446),
      tertiaryContainer: Color(0xff284b5e),
      onTertiaryContainer: Color(0xffc4e7ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff0f1512),
      onBackground: Color(0xffdee4e0),
      surface: Color(0xff0f1512),
      onSurface: Color(0xffdee4e0),
      surfaceVariant: Color(0xff3f4945),
      onSurfaceVariant: Color(0xffbfc9c3),
      outline: Color(0xff89938e),
      outlineVariant: Color(0xff3f4945),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e0),
      inverseOnSurface: Color(0xff2b322f),
      inversePrimary: Color(0xff116b56),
      primaryFixed: Color(0xffa3f2d8),
      onPrimaryFixed: Color(0xff002018),
      primaryFixedDim: Color(0xff87d6bc),
      onPrimaryFixedVariant: Color(0xff005140),
      secondaryFixed: Color(0xffcee9dd),
      onSecondaryFixed: Color(0xff072019),
      secondaryFixedDim: Color(0xffb2ccc1),
      onSecondaryFixedVariant: Color(0xff344c43),
      tertiaryFixed: Color(0xffc4e7ff),
      onTertiaryFixed: Color(0xff001e2c),
      tertiaryFixedDim: Color(0xffa8cbe2),
      onTertiaryFixedVariant: Color(0xff284b5e),
      surfaceDim: Color(0xff0f1512),
      surfaceBright: Color(0xff343b38),
      surfaceContainerLowest: Color(0xff090f0d),
      surfaceContainerLow: Color(0xff171d1a),
      surfaceContainer: Color(0xff1b211e),
      surfaceContainerHigh: Color(0xff252b29),
      surfaceContainerHighest: Color(0xff303633),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8bdac0),
      surfaceTint: Color(0xff87d6bc),
      onPrimary: Color(0xff001b13),
      primaryContainer: Color(0xff509f87),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb6d1c6),
      onSecondary: Color(0xff031a14),
      secondaryContainer: Color(0xff7d968c),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffacd0e6),
      onTertiary: Color(0xff001925),
      tertiaryContainer: Color(0xff7395ab),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0f1512),
      onBackground: Color(0xffdee4e0),
      surface: Color(0xff0f1512),
      onSurface: Color(0xfff6fcf8),
      surfaceVariant: Color(0xff3f4945),
      onSurfaceVariant: Color(0xffc3cdc8),
      outline: Color(0xff9ba5a0),
      outlineVariant: Color(0xff7b8581),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e0),
      inverseOnSurface: Color(0xff252b29),
      inversePrimary: Color(0xff005241),
      primaryFixed: Color(0xffa3f2d8),
      onPrimaryFixed: Color(0xff00150f),
      primaryFixedDim: Color(0xff87d6bc),
      onPrimaryFixedVariant: Color(0xff003e31),
      secondaryFixed: Color(0xffcee9dd),
      onSecondaryFixed: Color(0xff00150f),
      secondaryFixedDim: Color(0xffb2ccc1),
      onSecondaryFixedVariant: Color(0xff233b33),
      tertiaryFixed: Color(0xffc4e7ff),
      onTertiaryFixed: Color(0xff00131e),
      tertiaryFixedDim: Color(0xffa8cbe2),
      onTertiaryFixedVariant: Color(0xff153a4c),
      surfaceDim: Color(0xff0f1512),
      surfaceBright: Color(0xff343b38),
      surfaceContainerLowest: Color(0xff090f0d),
      surfaceContainerLow: Color(0xff171d1a),
      surfaceContainer: Color(0xff1b211e),
      surfaceContainerHigh: Color(0xff252b29),
      surfaceContainerHighest: Color(0xff303633),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffedfff6),
      surfaceTint: Color(0xff87d6bc),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff8bdac0),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffedfff6),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb6d1c6),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff8fbff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffacd0e6),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0f1512),
      onBackground: Color(0xffdee4e0),
      surface: Color(0xff0f1512),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff3f4945),
      onSurfaceVariant: Color(0xfff3fdf7),
      outline: Color(0xffc3cdc8),
      outlineVariant: Color(0xffc3cdc8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e0),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff003126),
      primaryFixed: Color(0xffa7f7dc),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff8bdac0),
      onPrimaryFixedVariant: Color(0xff001b13),
      secondaryFixed: Color(0xffd2ede1),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb6d1c6),
      onSecondaryFixedVariant: Color(0xff031a14),
      tertiaryFixed: Color(0xffceebff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffacd0e6),
      onTertiaryFixedVariant: Color(0xff001925),
      surfaceDim: Color(0xff0f1512),
      surfaceBright: Color(0xff343b38),
      surfaceContainerLowest: Color(0xff090f0d),
      surfaceContainerLow: Color(0xff171d1a),
      surfaceContainer: Color(0xff1b211e),
      surfaceContainerHigh: Color(0xff252b29),
      surfaceContainerHighest: Color(0xff303633),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
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


  List<ExtendedColor> get extendedColors => [
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
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
