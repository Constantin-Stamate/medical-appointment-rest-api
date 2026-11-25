import 'dart:convert';

import 'package:http/http.dart' as http;

class AppRemoteDataSource {
  static const baseUrl = 'https://test-api-jlbn.onrender.com/lab2026/v2';
  final http.Client client;

  const AppRemoteDataSource(this.client);

  Future<Map<String, dynamic>> fetchFeed() => _get('feed');

  Future<Map<String, dynamic>> fetchDetails() => _get('feed/details');

  Future<Map<String, dynamic>> _get(String path) async {
    final response = await client
        .get(
          Uri.parse('$baseUrl/$path'),
          headers: {'Accept': 'application/json'},
        )
        .timeout(const Duration(seconds: 60));

    if (response.statusCode != 200) {
      throw http.ClientException(
        'HTTP ${response.statusCode}',
        Uri.parse('$baseUrl/$path'),
      );
    }

    return jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
  }
}