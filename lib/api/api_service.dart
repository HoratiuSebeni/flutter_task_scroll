import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://www.motesplatsen.se/api/v1/test/users"; 

  Future<List<dynamic>> fetchData(int page) async {
    final response = await http.get(Uri.parse('$baseUrl?pageNr=$page'));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<dynamic>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
