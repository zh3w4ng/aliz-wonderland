import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wonderland/theme.dart';

void main() {
  test('MaterialTheme - light', () {
    expect(MaterialTheme.lightScheme().primary, const Color(0xff116b56));
    expect(MaterialTheme.lightScheme().secondary, const Color(0xff4b635b));
    expect(const MaterialTheme(TextTheme()).light().colorScheme.primary, const Color(0xff116b56));
    expect(const MaterialTheme(TextTheme()).light().colorScheme.secondary, const Color(0xff4b635b));
  });

   test('MaterialTheme - dark', () {
    expect(MaterialTheme.darkScheme().primary, const Color(0xff87d6bc));
    expect(MaterialTheme.darkScheme().secondary, const Color(0xffb2ccc1));
    expect(const MaterialTheme(TextTheme()).dark().colorScheme.primary, const Color(0xff87d6bc));
    expect(const MaterialTheme(TextTheme()).dark().colorScheme.secondary, const Color(0xffb2ccc1));
  });
}