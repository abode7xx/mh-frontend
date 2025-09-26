
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final String token;

  const ApiClient({required this.baseUrl, required this.token});

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (token.isNotEmpty) 'Authorization': 'Bearer $token',
  };

  // Hotspot
  Future<void> hsCreateUser(String username, String password, {String? profile, String? comment}) async {
    final res = await http.post(Uri.parse('$baseUrl/hotspot/users'),
      headers: _headers,
      body: jsonEncode({
        'username': username,
        'password': password,
        if (profile != null) 'profile': profile,
        if (comment != null) 'comment': comment,
      }));
    if (res.statusCode != 200) throw Exception('Create HS failed: ${res.body}');
  }

  Future<void> hsDeleteUser(String name) async {
    final res = await http.delete(Uri.parse('$baseUrl/hotspot/users/$name'), headers: _headers);
    if (res.statusCode != 200) throw Exception('Delete HS failed: ${res.body}');
  }

  Future<List<dynamic>> hsActive() async {
    final res = await http.get(Uri.parse('$baseUrl/hotspot/active'), headers: _headers);
    if (res.statusCode != 200) throw Exception('Active HS failed: ${res.body}');
    return (jsonDecode(res.body) as Map)['rows'] as List<dynamic>;
  }

  Future<List<dynamic>> hsHosts() async {
    final res = await http.get(Uri.parse('$baseUrl/hotspot/hosts'), headers: _headers);
    if (res.statusCode != 200) throw Exception('Hosts HS failed: ${res.body}');
    return (jsonDecode(res.body) as Map)['rows'] as List<dynamic>;
  }

  // User Manager
  Future<void> umCreateUser(String username, String password, {int sharedUsers = 1, String customer = 'admin', String? profile}) async {
    final res = await http.post(Uri.parse('$baseUrl/um/users'),
      headers: _headers,
      body: jsonEncode({
        'username': username,
        'password': password,
        'sharedUsers': sharedUsers,
        'customer': customer,
        if (profile != null) 'profile': profile,
      }));
    if (res.statusCode != 200) throw Exception('Create UM failed: ${res.body}');
  }

  Future<void> umDeleteUser(String username) async {
    final res = await http.delete(Uri.parse('$baseUrl/um/users/$username'), headers: _headers);
    if (res.statusCode != 200) throw Exception('Delete UM failed: ${res.body}');
  }
}
