import '../domain.dart';



abstract class LoadSurveys {
  Future<List<SurveyEntity>> load();
}


