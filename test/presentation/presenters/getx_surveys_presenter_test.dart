import 'package:meta/meta.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class GetxSurveysPresenter {
  final LoadSurveys loadSurveys;

  GetxSurveysPresenter({@required this.loadSurveys});

  Future<void> loadData() async {
     await loadSurveys.load();
  }
}

class LoadSurveysSpy extends Mock implements LoadSurveys {}
void main(){

  test('Should call loadSurveys on loadData', () async {
    
    final loadSurveys = LoadSurveysSpy();
    final sut = GetxSurveysPresenter( loadSurveys: loadSurveys);


   await  sut.loadData();

   verify(loadSurveys.load()).called(1);
  });
}