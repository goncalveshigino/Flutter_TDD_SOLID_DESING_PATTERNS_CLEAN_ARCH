import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<Map> request({
    @required String url,
    @required String method,
    Map body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    final response = await client.post(Uri.parse(url), headers: headers, body: jsonBody);
   return jsonDecode(response.body);
  }
}

class ClientSpay extends Mock implements Client {}

void main() {
  HttpAdapter sut;
  ClientSpay client;
  String url;

  setUp(() {
    client = ClientSpay();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });
  group('post', () {
    test('Should calls post with correct values', () async {

      when(client.post(any, body: anyNamed('body'), headers: anyNamed('headers')))
      .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));
      await sut.request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(
        client.post(Uri.parse(url),
            headers: {
              'content-type': 'application/json',
              'accept': 'application/json',
            },
            body: '{"any_key":"any_value"}'),
      );
    });

    test('Should calls post without body', () async {
      when(client.post(any, body: anyNamed('body'), headers: anyNamed('headers')))
      .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));
      await sut.request(url: url, method: 'post');

      verify(
        client.post(any, headers: anyNamed('headers')),
      );
    });

    test('Should return data if post returns 200', () async {

      when(client.post(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });
  });
}
