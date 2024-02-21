import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wonderland/typography.dart';

class CompaniesSwiper extends StatelessWidget {
  const CompaniesSwiper({Key? key}) : super(key: key);

  AnimatedContainer _buildCountryImage(BuildContext context, String code) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: TypographyUtil.labelSmall(context).fontSize! * 1.5,
        height: TypographyUtil.labelSmall(context).fontSize! * 1.25,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("icons/flags/png100px/$code.png",
                  package: 'country_icons')),
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ));
  }

  GridTile _buildGridTile(
      BuildContext context, String companyLogo, String name, String countryCode) {
    const double height = 48;
    return GridTile(
        child: Container(
            alignment: Alignment.center,
            child: Column(children: [
              const SizedBox(height: 16),
              SizedBox(
                height: height,
                child: SvgPicture.asset("assets/icons/companies/$companyLogo.svg",
                    height: height,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.secondary,
                        BlendMode.srcIn)),
              ),
              const SizedBox(height: 16),
              Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    _buildCountryImage(context, countryCode),
                    const SizedBox(width: 4),
                    Text(
                      name,
                      style: TypographyUtil.labelSmall(context)
                    )
                  ])),
            ])));
  }

  @override
  Widget build(BuildContext context) {
    GridTile roomorama = _buildGridTile(
        context, 'roomorama-logo', 'Roomorama.', 'sg');
    GridTile highspot = _buildGridTile(
        context, 'highspot-logo', 'Highspot', 'us');
    GridTile sia = _buildGridTile(
        context,
        'singapore-airlines-logo',
        'SIA',
        'sg');
    GridTile thirtyThree = _buildGridTile(
        context, '33-logo', '33Across', 'us');
    GridTile kpler = _buildGridTile(
        context, 'kpler-logo', 'Kpler', 'fr');
    GridTile vertex = _buildGridTile(
        context, 'vertex-logo', 'Vertex', 'sg');
    GridTile moneyHero = _buildGridTile(context,
        'money-hero-logo', 'MoneyHero', 'sg');
    GridTile viki = _buildGridTile(context,
        'rakuten-viki-logo', 'Viki', 'jp');
    List<GridTile> children = <GridTile>[
      highspot,
      sia,
      thirtyThree,
      vertex,
      kpler,
      moneyHero,
      viki,
      roomorama
    ];

    return Column(
      children: [
        const SizedBox(height: 24),
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Companies',
              style: TypographyUtil.headlineLarge(context)
            )),
        SizedBox(
            width: double.infinity,
            height: 128,
            child: Swiper(
              autoplay: true,
              itemBuilder: (BuildContext context, int index) {
                return children[index];
              },
              itemCount: children.length,
              pagination: SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                      activeColor:
                          Theme.of(context).colorScheme.secondary,
                      color: Theme.of(context).colorScheme.secondaryContainer)),
              viewportFraction: 0.33,
              control: SwiperControl(
                color: Theme.of(context).colorScheme.secondary
              ),
            ))
      ],
    );
  }
}
