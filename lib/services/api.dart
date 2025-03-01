import 'dart:convert';
import 'package:http/http.dart';

class APIService {
  final _baseUrl = 'https://api.npoint.io/1e25a45ef715d6db9718';

  _path(String url) {
    return Uri.parse(_baseUrl + url);
  }

  get(String url) async {
    try {
      final response = await Client().get(_path(url));
      if (response.statusCode == 200) {
        final responseObject = json.decode(response.body);
        return responseObject;
      }

      return throw ("APIService.get Error: $response");
    } catch (error) {
      throw ("APIService.get Error: $error");
    }
  }

  post(String url, Object data) async {
    try {
      final uri = _path(url);
      final response = await Client().post(uri, body: jsonEncode(data));

      if (response.statusCode == 200) {
        return response;
      }
    } catch (error) {
      throw ("APIService.post Error: $error");
    }
  }
}
