import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:intl/intl.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/domain/usecases/usecases.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/domain/entities/entities.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/ui/ui.dart';

class GetxSurveysPresenter {
  final LoadSurveys loadSurveys;

  final _isLoading = true.obs;
  final _surveys = Rx<List<SurveyViewModel>>();

  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<List<SurveyViewModel>> get surveysStream => _surveys.stream;

  GetxSurveysPresenter({@required this.loadSurveys});

  Future<void> loadData() async {
    _isLoading.value = true;
    final surveys = await loadSurveys.load();
    _surveys.value = surveys
        .map((survey) => SurveyViewModel(
          id: survey.id,
          question: survey.question,
          date: DateFormat('dd MMM yyyy').format(survey.dateTime),
          didAnswer: survey.didAnswer,
        ))
        .toList();
    _isLoading.value = false;
  }
}

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
        didAnswer: true),
    SurveyEntity(
        id: faker.guid.guid(),
        question: faker.lorem.sentence(),
        dateTime: DateTime(2020, 7, 2),
        didAnswer: false)
  ];

  void mockLoadSurveys(List<SurveyEntity> data) {
    surveys = data;
    when(loadSurveys.load()).thenAnswer((_) async => surveys);
  }

  setUp(() {
    loadSurveys = LoadSurveysSpy();
    sut = GetxSurveysPresenter(loadSurveys: loadSurveys);
    mockLoadSurveys(mockValidData());
  });

  test('Should call loadSurveys on loadData', () async {
    await sut.loadData();

    verify(loadSurveys.load()).called(1);
  });

  test('Should call loadSurveys on loadData', () async {
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
}
