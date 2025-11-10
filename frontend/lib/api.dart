import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  String? _token;

  ApiClient({this.baseUrl = 'http://localhost:3000'});

  void setToken(String token) => _token = token;
  String? get token => _token;

  Map<String, String> _headers() => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Future<String> login(String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: _headers(),
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final token = data['accessToken'] as String;
      setToken(token);
      return token;
    }
    throw Exception('Falha no login: ${res.statusCode}');
  }

  Future<List<dynamic>> getClients() async {
    final res = await http.get(Uri.parse('$baseUrl/clients'));
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as List<dynamic>;
    }
    throw Exception('Falha ao buscar clientes');
  }

  Future<List<dynamic>> getProducts({String? search, String? client}) async {
    final qs = {
      if (search != null && search.isNotEmpty) 'search': search,
      if (client != null && client.isNotEmpty) 'client': client,
    };
    final uri = Uri.parse('$baseUrl/products').replace(queryParameters: qs);
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return (data['items'] as List<dynamic>);
    }
    throw Exception('Falha ao buscar produtos');
  }

  Future<Map<String, dynamic>> getProductById(String id, {String? client}) async {
    final qs = {if (client != null && client.isNotEmpty) 'client': client};
    final uri = Uri.parse('$baseUrl/products/$id').replace(queryParameters: qs);
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    }
    throw Exception('Falha ao buscar produto');
  }
}
