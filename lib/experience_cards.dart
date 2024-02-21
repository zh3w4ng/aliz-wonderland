import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:wonderland/typography.dart';

class ExperienceCards extends StatefulWidget {
  const ExperienceCards({super.key});

  @override
  State<ExperienceCards> createState() => _ExperienceCardsState();
}

class _ExperienceCardsState extends State<ExperienceCards> {
  var doc = rootBundle
      .loadString('assets/json/experience.json')
      .then((e) => json.decode(e));

  Text _buildSubtitle(BuildContext context, String subtitle) {
    return Text(subtitle, style: TypographyUtil.keywordsList(context));
  }

  Text _buildTitle(BuildContext context, String title) {
    return Text(title, style: TypographyUtil.keywordsTitle(context));
  }

  Column _buildTime(BuildContext context, String from, String to) {
    TextStyle style = TypographyUtil.keywordsList(context);
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(from, style: style),
      Text('-', style: style),
      Text(to, style: style)
    ]);
  }

  ListTile _buildListTile(BuildContext context, double height, String path,
      String title, String subtitle) {
    return ListTile(
        leading: SizedBox(
          height: height,
          child: SvgPicture.asset(path,
              height: height,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
        ),
        title: _buildTitle(context, title),
        subtitle: _buildSubtitle(context, subtitle));
  }

  Padding _buildSummaryColumn(BuildContext context, List summary) {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...summary.map((e) =>
                      Text("- $e", style: TypographyUtil.keywordsList(context)))
                ])));
  }

  Chip _buildKeywordChip(BuildContext context, String keyword) {
    return Chip(
        labelStyle: TypographyUtil.keywordsList(context),
        label: Text(keyword),
        padding: const EdgeInsets.all(0));
  }

  Padding _buildKeywordsRow(BuildContext context, List keywords) {
    return Padding(padding: const EdgeInsets.only(left: 16, right: 16), child:  Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      runSpacing: 4,
      children: <Widget>[
        Text('Keywords:', style: TypographyUtil.keywordsTitle(context)),
        ...keywords.map((keyword) => _buildKeywordChip(context, keyword)),
      ],
    ));
  }

  Card _builCard(BuildContext context, Map<String, dynamic> entry) {
    return Card(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
          _buildListTile(
              context, 32, entry['logo'], entry['title'], entry['company']),
          _buildSummaryColumn(context, entry['summary']),
          _buildKeywordsRow(context, entry['keywords']),
          const SizedBox(
            height: 8,
          )
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: doc,
        builder: (context, snapshot) => snapshot.data != null
            ? Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Timeline.tileBuilder(
                theme: TimelineTheme.of(context).copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  nodePosition: 0.1,
                ),
                builder: TimelineTileBuilder.fromStyle(
                  contentsAlign: ContentsAlign.basic,
                  oppositeContentsBuilder: (context, index) => _buildTime(
                      context,
                      snapshot.data![index]['to'],
                      snapshot.data![index]['from']),
                  contentsBuilder: (context, index) =>
                      _builCard(context, snapshot.data![index]),
                  itemCount: snapshot.data!.length,
                ),
              ))
            : const SizedBox.shrink());
  }
}
