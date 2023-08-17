import 'package:meta/meta.dart';

import '../../../domain/domain.dart';
import '../../data.dart';

class RemoteLoadSurveys implements LoadSurveys {
  
  final String url;
  final HttpClient<List<Map>> httpClient;

  RemoteLoadSurveys({
    @required this.url,
    @required this.httpClient,
  });

  @override
  Future<List<SurveyEntity>> load() async {
    try {
    final httpResponse = await httpClient.request(url: url, method: 'get');
    return httpResponse.map((json) => RemoteSurveyModel.fromJson(json).toEntity()).toList();
    } on HttpError catch(error) {
      throw error == HttpError.forbidden
         ? DomainError.accessDenied
         : DomainError.unexpected;
    }
  }
}