import 'package:flutter/material.dart';

class TypographyUtil {
  static TextStyle headlineLargeOS(BuildContext context) {
    return Typography.material2021().dense.headlineLarge!.copyWith(
        fontFamily: 'Bodoni 72 OS',
        color: Theme.of(context).colorScheme.onSecondaryContainer);
  }

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

  static TextStyle storyHeadlineMediumBold(BuildContext context) {
    return Typography.material2021().dense.headlineMedium!.copyWith(
        fontFamily: 'Bodoni 72 Smallcaps',
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w800);
  }
  static TextStyle snackBarErrorLabelMedium(BuildContext context) {
    return Typography.material2021().dense.labelMedium!.copyWith(
        fontFamily: 'Bodoni 72',
        color: Theme.of(context).colorScheme.onErrorContainer);
  }

  static TextStyle snackBarLabelMedium(BuildContext context) {
    return Typography.material2021().dense.labelMedium!.copyWith(
        fontFamily: 'Bodoni 72',
        color: Theme.of(context).colorScheme.onPrimary);
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
    return Typography.material2021()
        .dense
        .titleMedium!
        .copyWith(fontFamily: 'Bodoni 72');
  }

  static TextStyle keywordsTitle(BuildContext context) {
    return TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontFamily: 'Bodoni 72',
        fontWeight: FontWeight.bold);
  }

  static TextStyle keywordsList(BuildContext context) {
    return TextStyle(
        color: Theme.of(context).colorScheme.primary, fontFamily: 'Bodoni 72');
  }
}
