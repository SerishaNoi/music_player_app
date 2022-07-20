import 'dart:convert';
import 'package:http/http.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  dynamic get(String path, {Map<String, dynamic>? quaryParams}) async {
    final Response response = await _client.get(
      Uri.https('itunes.apple.com', path, quaryParams),
      headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
      },
    );

    if (response.statusCode == 200){
      return jsonDecode(response.body);
    } else {
      throw Exception('failed to load data');
    }
  }
}
