
import '../../../../presentation/presentation.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';



SurveysPresenter makeGetxSurveysPresenter() {
  return GetxSurveysPresenter(
    loadSurveys: makeRemoteLoadSurveys(), 

  );
 
}