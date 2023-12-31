import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

import '../../ui.dart';

class SurveysPage extends StatelessWidget {
  final SurveysPresenter presenter;

  const SurveysPage(this.presenter, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    presenter.loadData();

    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.surveys),
        backgroundColor: makeAppTheme().primaryColor,
      ),
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream.listen((isLoading) {
            if (isLoading == true) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          return StreamBuilder<List<SurveyViewModel>>(
              stream: presenter.surveysStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                  
                        Text(snapshot.error, style:  const TextStyle( fontSize: 16), textAlign: TextAlign.center,),
                        const SizedBox( height: 10 ),
                        ElevatedButton(
                          onPressed: presenter.loadData,
                          child: Text(R.strings.reload),
                        )
                      ],
                    ),
                  );
                }

                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        aspectRatio: 1,
                      ),
                      items: snapshot.data
                          .map((viewModel) => SurveyItem(viewModel))
                          .toList(),
                    ),
                  );
                }
                return const SizedBox(height: 0);
              });
        },
      ),
    );
  }
}
