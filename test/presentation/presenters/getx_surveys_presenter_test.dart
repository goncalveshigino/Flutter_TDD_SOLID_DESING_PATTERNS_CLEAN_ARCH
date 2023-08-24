import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/domain/usecases/usecases.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/domain/entities/entities.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/domain/helpers/helpers.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/ui/ui.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/presentation/presenter/presenter.dart';

class LoadSurveysSpy extends Mock implements LoadSurveys {}

void main() {
  GetxSurveysPresenter sut;
  LoadSurveysSpy loadSurveys;
  List<SurveyEntity> surveys;

  List<SurveyEntity> mockValidData() => [
    SurveyEntity(
      id: faker.guid.guid(),
      question: faker.lorem.sentence(),
      dateTime: DateTime(2023, 8, 22),
      didAnswer: true,
    ),
    SurveyEntity(
      id: faker.guid.guid(),
      question: faker.lorem.sentence(),
      dateTime: DateTime(2020, 7, 2), 
      didAnswer: false,
    ),
   ];

  PostExpectation mockLoadSurveysCall() => when(loadSurveys.load());

  void mockLoadSurveys(List<SurveyEntity> data) {
    surveys = data;
    mockLoadSurveysCall().thenAnswer((_) async => surveys);
  }

  void mockLoadSurveysError() =>
      mockLoadSurveysCall().thenThrow(DomainError.unexpected);

  setUp(() {
    loadSurveys = LoadSurveysSpy();
    sut = GetxSurveysPresenter(loadSurveys: loadSurveys);
    mockLoadSurveys(mockValidData());
  });

  test('Should call loadSurveys on loadData', () async {
    await sut.loadData();

    verify(loadSurveys.load()).called(1);
  });

  test('Should emit correct events on success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.surveysStream.listen(expectAsync1((surveys) => expect(surveys, [
          SurveyViewModel(
              id: surveys[0].id,
              question: surveys[0].question,
              date: '22 Ago 2023',
              didAnswer: surveys[0].didAnswer),
          SurveyViewModel(
              id: surveys[1].id,
              question: surveys[1].question,
              date: '02 Jul 2023',
              didAnswer: surveys[1].didAnswer),
        ])));

    await sut.loadData();
  });

  test('Should emit correct events on failure', () async {
    mockLoadSurveysError();

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.surveysStream.listen(null,
        onError: expectAsync1(
            (error) => expect(error, UIError.unexpected.description)));

    await sut.loadData();
  });
}
