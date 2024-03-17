import 'package:flutter/material.dart';
import 'package:wonderland/typography.dart';

class Footer extends StatelessWidget {
  final double height;
  const Footer({Key? key, required this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child:  Center(
        child: Text(
          'Copyright © 2024 Zhe Wang. All Rights Reserved',
          style: TypographyUtil.keywordsList(context)
        ),
      ),
    );
  }
}