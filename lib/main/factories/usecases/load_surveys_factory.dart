import '../../../data/usecases/use_cases.dart';
import '../../../domain/usecases/usecases.dart';
import '../http/http.dart';


LoadSurveys makeRemoteLoadSurveys() {
  return RemoteLoadSurveys(
    httpClient: makeHttpAdapter(),
      url: makeApiUrl('surveys'),
  );

}