import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  Future<Map> request(
      {@required String url, @required String method, Map body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };

    final jsonBody = body != null ? jsonEncode(body) : null;

    final resposnse = await client.post(url, headers: headers, body: jsonBody);

    if (resposnse.statusCode == 200) {
      return resposnse.body.isEmpty ? null : jsonDecode(resposnse.body);
    } else {
      return null;
    }
  }
}
