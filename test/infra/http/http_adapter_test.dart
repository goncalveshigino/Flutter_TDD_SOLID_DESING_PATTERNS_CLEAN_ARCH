import 'package:faker/faker.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request({
    @required String url,
    @required String method,
  }) async {
    await client.post(Uri.parse(url));
  }
}

class ClientSpay extends Mock implements Client {}

void main() {
  group('post', () {});

  test('Should calls post with correct values', () async {
    
    final client = ClientSpay();
    final sut = HttpAdapter(client);
    final url = faker.internet.httpUrl();

    await sut.request(url: url, method: 'post');

    verify(client.post(Uri.parse(url)));
  });
}
