import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

import '../../ui.dart';
import 'components/components.dart';

class SurveysPage extends StatelessWidget {
  const SurveysPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.surveys),
        backgroundColor: makeAppTheme().primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CarouselSlider(
          options: CarouselOptions(enlargeCenterPage: true, aspectRatio: 1),
          items: const [
            SurveyItem(),
            SurveyItem(),
            SurveyItem(),
          ],
        ),
      ),
    );
  }
}

