import 'dart:html';

import 'package:flutter/material.dart';

class TypographyUtil {
  static TextStyle headlineLarge(BuildContext context) {
    return Typography.material2021().dense.headlineLarge!.copyWith(
        fontFamily: 'Bodoni 72 Smallcaps Book',
        color: Theme.of(context).colorScheme.primary);
  }

  static TextStyle headlineLargeBold(BuildContext context) {
    return Typography.material2021().dense.headlineLarge!.copyWith(
        fontFamily: 'Bodoni 72 Smallcaps Book',
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w800);
  }

  static TextStyle headlineMediumBold(BuildContext context) {
    return Typography.material2021().dense.headlineMedium!.copyWith(
        fontFamily: 'Bodoni 72 Smallcaps Book',
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w800);
  }
  static TextStyle labelMedium(BuildContext context) {
    return Typography.material2021().dense.labelMedium!.copyWith(
        fontFamily: 'Bodoni 72',
        color: Theme.of(context).colorScheme.secondary);
  }

  static TextStyle labelSmall(BuildContext context) {
    return Typography.material2021().dense.labelSmall!.copyWith(
        fontFamily: 'Bodoni 72',
        color: Theme.of(context).colorScheme.secondary);
  }

  static TextStyle titleLarge(BuildContext context) {
    return Typography.material2021().dense.titleLarge!.copyWith(
        fontFamily: 'Bodoni 72 Smallcaps Book',
        color: Theme.of(context).colorScheme.primary);
  }

  static TextStyle titleMedium(BuildContext context) {
    return Typography.material2021().dense.titleMedium!.copyWith(
        fontFamily: 'Bodoni 72 Smallcaps Book',
        color: Theme.of(context).colorScheme.primary);
  }

  static TextStyle wordCloudMax(BuildContext context) {
    return Typography.material2021().dense.titleMedium!.copyWith(
        fontFamily: 'Bodoni 72');
  }

}
