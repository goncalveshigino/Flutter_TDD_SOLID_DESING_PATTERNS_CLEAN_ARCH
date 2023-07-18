import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/infra/http/http.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/data/http/http.dart';



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

    PostExpectation mockRequest() => when(
        client.post(any, body: anyNamed('body'), headers: anyNamed('headers')));

    void mockResponse(int statusCode,{String body = '{"any_key":"any_value"}'}) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    setUp(() {
      mockResponse(200);
    });

    test('Should calls post with correct values', () async {
   
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
      await sut.request(url: url, method: 'post');

      verify(
        client.post(any, headers: anyNamed('headers')),
      );
    });

    test('Should return data if post returns 200', () async {
      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null if post returns 200 with no data', () async {
      mockResponse(200, body: '');
      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });


    test('Should return null if post returns 204', () async {
      mockResponse(204, body: '');
      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });


    test('Should return null if post returns 204 with data', () async {
      mockResponse(204);
      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });

    test('Should return BadRequestError if post return 400', () async {
      mockResponse(400);

      final future =  sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return BadRequestError if post return 400', () async {
      mockResponse(400, body: '');

      final future =  sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });


    test('Should return BadRequestError if post return 400', () async {
      mockResponse(400);

      final future =  sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });
  });
}