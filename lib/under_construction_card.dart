import 'package:flutter/material.dart';
import 'package:wonderland/typography.dart';

class UnderConstructionCard extends StatefulWidget {
  const UnderConstructionCard({super.key, this.blendMode = BlendMode.overlay});

  final BlendMode blendMode;
  @override
  _UnderConstructionCardState createState() => _UnderConstructionCardState();
}

class _UnderConstructionCardState extends State<UnderConstructionCard> {
  @override
  Widget build(BuildContext context) {
    double height = 600;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child:
      Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.secondaryContainer,
                      widget.blendMode),
                  fit: BoxFit.cover,
                  image: const AssetImage(
                      'assets/images/alice-in-borderland.jpeg')),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).colorScheme.secondary,
                    offset: const Offset(3, 3),
                    blurRadius: 5)
              ]
            ),
          ),
          Center(
              heightFactor: 1.5,
              child: Text('Stories to be told...',
                  style: TypographyUtil.headlineLargeOS(context)))
        ],
      ),
    );
  }
}
