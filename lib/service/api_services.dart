import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://cloud.jezt.tech/api/jezt';

  static Future<String?> login(String companyId, String password) async {
    final url = Uri.parse('$baseUrl/token/');
    final response = await http.post(url, body: {
      'company_id': companyId,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['access'];
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> fetchDashboard(String token) async {
  final url = Uri.parse('https://cloud.jezt.tech/api/viewfromjson/');
  final response = await http.get(url, headers: {
    'Authorization': 'Bearer $token',
  });

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return null;
  }
}


  static Future<void> logout(String token) async {
    final url = Uri.parse('https://cloud.jezt.tech/api/logout/');
    await http.post(url, headers: {
      'Authorization': 'Bearer $token',
    });
  }
}
