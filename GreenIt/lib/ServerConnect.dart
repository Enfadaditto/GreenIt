import 'dart:convert';
import 'package:http/http.dart' as http;

class ServerConnect {
  final String url;

  ServerConnect(this.url);

  Future<String> fetchData() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the JSON response and return it as a formatted string
        final data = jsonDecode(response.body);
        return jsonEncode(data);
      } else {
        throw Exception('Failed to connect to the server');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
