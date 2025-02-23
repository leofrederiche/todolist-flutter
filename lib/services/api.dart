import 'dart:convert';

import 'package:http/http.dart';

class APIService {
  final _baseUrl = 'https://api.npoint.io/1e25a45ef715d6db9718';

  _path(String url) {
    return Uri.parse(_baseUrl + url);
  }

  get(String url) async {
    final response = await Client().get(_path(url));
    if (response.statusCode == 200) {
      final responseObject = json.decode(response.body);
      return responseObject;
    }

    return throw("APIService.get Error: $response");
  }

  post(String url, String data) async {
    final uri = _path(url);
    final response = await Client().post(
      uri, 
      body: json.encode(data),
    );

    print("!!!! URI: $uri");
    print("!!! Response.status: ${response.statusCode}");
    print("!!!!!!!!! Response: ${response.body}");

    if (response.statusCode == 200) {
      return response;
    }
  }
}