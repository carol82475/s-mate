import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:5000/api',
  );
}

class ApiAuth extends ChangeNotifier {
  ApiAuth._();

  static final ApiAuth instance = ApiAuth._();

  static const _accessTokenKey = 'api_access_token';
  static const _refreshTokenKey = 'api_refresh_token';

  String? _accessToken;
  String? _refreshToken;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  bool get isLoggedIn => _accessToken != null && _accessToken!.isNotEmpty;
  Map<String, dynamic>? get claims => _decodeJwt(_accessToken);
  String? get userId =>
      claims?['sub']?.toString() ??
      claims?[
              'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier']
          ?.toString();
  String? get email =>
      claims?['email']?.toString() ??
      claims?[
              'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress']
          ?.toString();

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString(_accessTokenKey);
    _refreshToken = prefs.getString(_refreshTokenKey);
    notifyListeners();
  }

  Future<void> save({
    required String accessToken,
    required String refreshToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    notifyListeners();
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
    _accessToken = null;
    _refreshToken = null;
    notifyListeners();
  }

  static Map<String, dynamic>? _decodeJwt(String? token) {
    if (token == null || token.isEmpty) return null;

    final parts = token.split('.');
    if (parts.length < 2) return null;

    try {
      final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      final decoded = jsonDecode(payload);
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (_) {
      return null;
    }
  }
}

class ApiClient {
  static Future<Map<String, String>> _headers({bool auth = true}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (auth) {
      if (ApiAuth.instance.accessToken == null) {
        await ApiAuth.instance.load();
      }

      final token = ApiAuth.instance.accessToken;

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

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await post(
      '/auth/login',
      auth: false,
      body: {
        'email': email,
        'password': password,
      },
    );

    await _saveAuthResponse(response);
    return response;
  }

  static Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    String? nationality,
    String language = 'en',
  }) async {
    final response = await post(
      '/auth/register',
      auth: false,
      body: {
        'email': email,
        'password': password,
        'nationality': nationality,
        'language': language,
      },
    );

    await _saveAuthResponse(response);
    return response;
  }

  static Future<void> logout() => ApiAuth.instance.clear();

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

  static Future<void> _saveAuthResponse(Map<String, dynamic> response) async {
    final data = response['data'];

    if (data is! Map<String, dynamic>) {
      return;
    }

    final accessToken = data['accessToken']?.toString();
    final refreshToken = data['refreshToken']?.toString();

    if (accessToken == null ||
        accessToken.isEmpty ||
        refreshToken == null ||
        refreshToken.isEmpty) {
      return;
    }

    await ApiAuth.instance.save(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
