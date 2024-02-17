import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wonderland/typography.dart';

class NameCard extends StatefulWidget {
  const NameCard({super.key});

  @override
  _NameCardState createState() => _NameCardState();
}

class _NameCardState extends State<NameCard> {
  @override
  Widget build(BuildContext context) {
    double height = 272;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: 1.0,
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
              
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 24,
          right: 8,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi, I\'m Zhe Wang,'),
                  Text('a Seasoned Data Artisan.')
                ]),
            style: TypographyUtil.headlineMediumBold(context),
          ),
        ),
        Positioned(
            right: 24,
            top: 112,
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
            top: 144,
            left: 16,
            child: Container(
              height: 112,
                alignment: Alignment.bottomLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
