import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:5000/api/v1',
  );
}

class ApiClient {
  static Future<Map<String, String>> _headers({bool auth = true}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (auth) {
      final token = Supabase.instance.client.auth.currentSession?.accessToken;

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  static Future<Map<String, dynamic>> get(
    String path, {
    bool auth = true,
  }) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}$path'),
      headers: await _headers(auth: auth),
    );

    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    bool auth = true,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}$path'),
      headers: await _headers(auth: auth),
      body: jsonEncode(body ?? {}),
    );

    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
    bool auth = true,
  }) async {
    final response = await http.put(
      Uri.parse('${ApiConfig.baseUrl}$path'),
      headers: await _headers(auth: auth),
      body: jsonEncode(body ?? {}),
    );

    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> patch(
    String path, {
    Map<String, dynamic>? body,
    bool auth = true,
  }) async {
    final response = await http.patch(
      Uri.parse('${ApiConfig.baseUrl}$path'),
      headers: await _headers(auth: auth),
      body: jsonEncode(body ?? {}),
    );

    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> delete(
    String path, {
    bool auth = true,
  }) async {
    final response = await http.delete(
      Uri.parse('${ApiConfig.baseUrl}$path'),
      headers: await _headers(auth: auth),
    );

    return _handleResponse(response);
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    dynamic decoded;

    try {
      decoded = response.body.isNotEmpty ? jsonDecode(response.body) : {};
    } catch (_) {
      decoded = {
        'success': false,
        'message': response.body,
      };
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      return {
        'success': true,
        'data': decoded,
      };
    }

    final message = decoded is Map<String, dynamic>
        ? decoded['message'] ?? decoded['error'] ?? 'Request failed'
        : 'Request failed';

    throw Exception(message);
  }
}
