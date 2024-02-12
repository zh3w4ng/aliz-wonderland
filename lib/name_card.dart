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
  final thresholdshadowColor = const Color.fromRGBO(124, 78, 50, 0.5);
  final aquaColor = const Color.fromRGBO(32, 68, 80, 1);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 300),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.cover,
                // colorFilter: ColorFilter.mode(
                //     Colors.black.withOpacity(0.5), BlendMode.darken),
                image: AssetImage('assets/images/background.png'),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(shadow, shadow),
                  color: thresholdshadowColor,
                  blurRadius: shadow,
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(radius),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(36),
          width: double.infinity,
          height: 400,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            child:
                const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Hi, I\'m Zhe Wang,'),
              Text('a Seasoned Artisan in Data Engineering.'),
              SizedBox(
                height: 20,
              ),
            ]),
            style: TextStyle(
              fontFamily: 'Bodoni 72 Smallcaps Book',
              fontSize: width * 0.05,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Positioned(
            right: 32,
            bottom: 200,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconButton(
                  icon: SvgPicture.asset('assets/icons/linkedin.svg',
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.tertiary,
                          BlendMode.srcIn)),
                  onPressed: () {
                    launchUrlString('https://www.linkedin.com/in/zh3w4ng');
                  }),
              IconButton(
                  icon: SvgPicture.asset('assets/icons/mail.svg',
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.tertiary,
                          BlendMode.srcIn)),
                  color: Theme.of(context).colorScheme.tertiary,
                  onPressed: () {
                    launchUrlString('mailto:zh3w4ng@gmail.com?subject=Hello');
                  }),
            ])),
        Positioned(
            bottom: 80,
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
