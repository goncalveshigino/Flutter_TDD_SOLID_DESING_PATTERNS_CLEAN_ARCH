
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

  group('shared', () {
    test('Should throw ServerError if invalid method is provider', () async {
      final future = sut.request(url: url, method: 'invalid_method');

      expect(future, throwsA(HttpError.serverError));
    });
  });

  group('post', () {
    PostExpectation mockRequest() => when(
        client.post(any, body: anyNamed('body'), headers: anyNamed('headers')));

    void mockResponse(int statusCode,
        {String body = '{"any_key":"any_value"}'}) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    void mockError() {
      mockRequest().thenThrow(Exception());
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

      await sut.request(url: url, method: 'post', body: {'any_key': 'any_value'}, headers: {'any_header':'any_vaue'});
      verify(
        client.post(Uri.parse(url),
            headers: {
              'content-type': 'application/json',
              'accept': 'application/json',
              'any_header':'any_vaue'
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

    test('Should return badRequestError if post return 400', () async {
      mockResponse(400);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return badRequestError if post return 400', () async {
      mockResponse(400, body: '');

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return badRequestError if post return 400', () async {
      mockResponse(400);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return unauthorizedError if post return 401', () async {
      mockResponse(401);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.unauthorized));
    });

    test('Should return forbiddenError if post return 403', () async {
      mockResponse(403);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.forbidden));
    });

    test('Should return NotFoundError if post return 404', () async {
      mockResponse(404);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.notFound));
    });

    test('Should return serverError if post return 500', () async {
      mockResponse(500);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.serverError));
    });

    test('Should return serverError if post throws', () async {
      mockError();

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.serverError));
    });
  });

  group('get', () {

    PostExpectation mockRequest() => when(client.get(any, headers: anyNamed('headers')));

    void mockResponse(int statusCode,{String body = '{"any_key":"any_value"}'} ) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    void mockError() {
      mockRequest().thenThrow(Exception());
    }

    setUp(() {
      mockResponse(200);
    });

    test('Should calls get with correct values', () async {
      await sut.request(url: url, method: 'get');
      verify( client.get(
            Uri.parse(url),
            headers: {
              'content-type': 'application/json',
              'accept': 'application/json',
            },
          ),
      );

      await sut.request(url: url, method: 'get', headers: {'any_header': 'any_value'});
      verify(
        client.get(Uri.parse(url),
            headers: {
              'content-type': 'application/json',
              'accept': 'application/json',
              'any_header': 'any_value'
            },
          ),
      );
    });


    test('Should return data if get returns 200', () async {
      final response = await sut.request(url: url, method: 'get');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null if get returns 200 with no data', () async {
      mockResponse(200, body: '');
      final response = await sut.request(url: url, method: 'get');

      expect(response, null);
    });


     test('Should return null if get returns 204', () async {
      mockResponse(204, body: '');
      final response = await sut.request(url: url, method: 'get');

      expect(response, null);
    });

    test('Should return null if get returns 204 with data', () async {
      mockResponse(204);
      final response = await sut.request(url: url, method: 'get');

      expect(response, null);
    });


    test('Should return badRequestError if get return 400', () async {
      mockResponse(400, body: '');

      final future = sut.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return badRequestError if get return 400', () async {
      mockResponse(400);

      final future = sut.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return unauthorizedError if get return 401', () async {
      mockResponse(401);

      final future = sut.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.unauthorized));
    });

    test('Should return forbiddenError if get return 403', () async {
      mockResponse(403);

      final future = sut.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.forbidden));
    });

    test('Should return NotFoundError if get return 404', () async {
      mockResponse(404);

      final future = sut.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.notFound));
    });

    test('Should return serverError if get return 500', () async {
      mockResponse(500);

      final future = sut.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.serverError));
    });

    test('Should return serverError if get throws', () async {
      mockError();

      final future = sut.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.serverError));
    });

  });
}
