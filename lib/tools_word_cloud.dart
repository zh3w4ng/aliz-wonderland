import 'package:flutter/material.dart';
import 'package:word_cloud/word_cloud_data.dart';
import 'package:word_cloud/word_cloud_view.dart';
import 'package:word_cloud/word_cloud_shape.dart';
import 'package:wonderland/typography.dart';

class ToolsWordCloud extends StatelessWidget {
  const ToolsWordCloud({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double radius = 160;
    WordCloudData wcData = WordCloudData(data: [
      {'word': 'Airflow', 'value': 70},
      {'word': 'DBT', 'value': 70},
      {'word': 'Iceberg', 'value': 70},
      {'word': 'AWS', 'value': 90},
      {'word': 'Docker', 'value': 90},
      {'word': 'Flutter', 'value': 80},
      {'word': 'Postgresql', 'value': 80},
      {'word': 'Python', 'value': 80},
      {'word': 'TDD', 'value': 80},
      {'word': 'Terraform', 'value': 80},
      {'word': 'Kinesis', 'value': 80},
      {'word': 'Lambda', 'value': 80},
      {'word': 'Typescript', 'value': 80},
      {'word': 'S3', 'value': 80},
      {'word': 'Pandas', 'value': 80},
      {'word': 'Redshift', 'value': 80},
      {'word': 'Scrapy', 'value': 80},
      {'word': 'Athena', 'value': 80},
      {'word': 'PowerBI', 'value': 80},
      {'word': 'Hive', 'value': 80},
      {'word': 'Mysql', 'value': 80},
      {'word': 'CDK', 'value': 80},
      {'word': 'Scala', 'value': 80},
      {'word': 'Java', 'value': 80},
      {'word': 'Spark', 'value': 80},
      {'word': 'MongoDB', 'value': 80},
      {'word': 'Spark', 'value': 70},
      {'word': 'Akka', 'value': 70},
      {'word': 'ElasticSearch', 'value': 70},
      {'word': 'Parquet', 'value': 60},
      {'word': 'Avro', 'value': 60},
      {'word': 'Rails', 'value': 60},
      {'word': 'Kafka', 'value': 60},
      {'word': 'Kubernetes', 'value': 60},
      {'word': 'GatsbyJS', 'value': 60},
      {'word': 'PipeDrive', 'value': 60},
      {'word': 'React', 'value': 60},
      {'word': 'Protobuf', 'value': 60},
      {'word': 'Hadoop', 'value': 60},
      {'word': 'Kibana', 'value': 60},
      {'word': 'Solr', 'value': 60},
      {'word': 'OpsWorks', 'value': 60},
      {'word': 'Tableau', 'value': 60},
      {'word': 'Tez', 'value': 60},
      {'word': 'Fluentd', 'value': 60},
      {'word': 'HAProxy', 'value': 60},
      {'word': 'EMR', 'value': 60},
      {'word': 'R', 'value': 60},
      {'word': 'Fluentd', 'value': 60},
      {'word': 'Airflow', 'value': 50},
      {'word': 'Chef', 'value': 50},
      {'word': 'Azkaban', 'value': 50},
      {'word': 'Ruby', 'value': 50},
      {'word': 'Haskell', 'value': 40},
      {'word': 'Drupal', 'value': 40},
      {'word': 'Cassandra', 'value': 40},
      {'word': 'AngularJS', 'value': 40},
      {'word': 'Backbone', 'value': 40},
      {'word': 'Pig', 'value': 30},
      {'word': 'JQuery', 'value': 30},
      {'word': 'SPSS', 'value': 30},
      {'word': 'SAS', 'value': 30},
    ]);
    ColorScheme colorScheme = ThemeData(
      useMaterial3: true,
    ).colorScheme;
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            'Tools',
            style: TypographyUtil.headlineLarge(context)
          ),
        ),
        Center(
            child: WordCloudView(
          shape: WordCloudCircle(radius: radius),
          // mapcolor:  Theme.of(context).colorScheme.primary,
          data: wcData,
          maxtextsize: 24,
          mapwidth: radius * 2,
          mapheight: radius * 2,
          fontFamily: TypographyUtil.wordCloudMax(context).fontFamily,
          fontWeight: TypographyUtil.wordCloudMax(context).fontWeight,
          colorlist: [
            colorScheme.primary,
            colorScheme.secondary,
            colorScheme.tertiary,
          ],
        ))
      ],
    );
  }
}
