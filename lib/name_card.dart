import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NameCard extends StatefulWidget {
  const NameCard({super.key});

  @override
  _NameCardState createState() => _NameCardState();
}

class _NameCardState extends State<NameCard> {
  double shadow = 5;
  double radius = 10;
  double scale = 1.0;
  double opacity = 1.0;
  Color? textColor;
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    double height = 400;
    double badgeDistanceFromBottom = 16;
    double buttonDistanceFromBottom = 160;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 300),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Theme.of(context).colorScheme.brightness ==
                          Brightness.light
                      ? const AssetImage('assets/images/background-light.jpeg')
                      : const AssetImage('assets/images/background-dark.jpeg')),
              boxShadow: [
                BoxShadow(
                  offset: Offset(shadow, shadow),
                  color: Theme.of(context).colorScheme.secondary,
                  blurRadius: shadow,
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(radius),
              ),
            ),
          ),
        ),
        Positioned(
          top: 36,
          left: 36,
          right: 36,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi, I\'m Zhe Wang,'),
                  Text('a Seasoned Data Artisan.')
                ]),
            style: TextStyle(
              fontFamily: 'Bodoni 72',
              fontSize: width * 0.06,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Positioned(
            right: 32,
            bottom: buttonDistanceFromBottom,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconButton(
                  icon: SvgPicture.asset('assets/icons/linkedin.svg',
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode.srcIn)),
                  onPressed: () {
                    launchUrlString('https://www.linkedin.com/in/zh3w4ng');
                  }),
              IconButton(
                  icon: SvgPicture.asset('assets/icons/mail.svg',
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode.srcIn)),
                  color: Theme.of(context).colorScheme.tertiary,
                  onPressed: () {
                    launchUrlString('mailto:zh3w4ng@gmail.com?subject=Hello');
                  }),
            ])),
        Positioned(
            bottom: badgeDistanceFromBottom,
            left: 16,
            child: Container(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/badge.svg',
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.secondary,
                            BlendMode.srcIn)),
                    SvgPicture.asset('assets/icons/degrees.svg',
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.secondary,
                            BlendMode.srcIn)),
                  ],
                )))
      ],
    );
  }
}
