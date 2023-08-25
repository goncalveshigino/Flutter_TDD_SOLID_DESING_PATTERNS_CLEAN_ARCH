import 'dart:convert';
import 'package:meta/meta.dart';

import 'package:http/http.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<dynamic> request({
    @required String url,
    @required String method,
    Map body,
    Map headers
  }) async {
    
    final defaultHeaders = headers?.cast<String,String>() ?? {}..addAll(
    {
      'content-type': 'application/json',
      'accept': 'application/json'
    });

    final jsonBody = body != null ? jsonEncode(body) : null;

    var response = Response('', 500);

    try {
      if (method == 'post') {
        response = await client.post(Uri.parse(url), headers: defaultHeaders, body: jsonBody);
      } else if (method == 'get') {
        response = await client.get(Uri.parse(url), headers: defaultHeaders);
      }
    } catch (e) {
      throw HttpError.serverError;
    }

    return _handleResponse(response);
  }


  Map _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:  return response.body.isEmpty ? null : jsonDecode(response.body);
      case 204: return null;
      case 400: throw HttpError.badRequest;
      case 401: throw HttpError.unauthorized;
      case 403: throw HttpError.forbidden;
      case 404: throw HttpError.notFound;
      default: throw HttpError.serverError;

    }
  }
}
