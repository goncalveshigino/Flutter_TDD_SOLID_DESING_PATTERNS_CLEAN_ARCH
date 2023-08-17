import 'package:http/http.dart';
import 'package:meta/meta.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/data/http/http.dart';

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class RemoteLoadSurveys {
  final String url;
  final HttpClient httpClient;

  RemoteLoadSurveys({
    @required this.url,
    @required this.httpClient,
  });

  Future<void> load() async {
    await httpClient.request(url: url, method: 'get');
  }
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
    RemoteLoadSurveys sut;
    HttpClientSpy httpClient;
    String url;
  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteLoadSurveys(url: url, httpClient: httpClient);
  });
  test('Should call HttpClient with correct value', () async {
    await sut.load();

    verify(httpClient.request(url: url, method: 'get'));
  });
}
