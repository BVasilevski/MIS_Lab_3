import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<http.Response> getJokeTypes() async {
    var response = await http
        .get(Uri.parse("https://official-joke-api.appspot.com/types"));
    return response;
  }

  static Future<List<Map<String, dynamic>>> getJokesByType(String type) async {
    var response = await http.get(Uri.parse("https://official-joke-api.appspot.com/jokes/$type/ten"));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load jokes for type $type');
    }
  }

  static Future<dynamic> getJokeOfTheDay() async {
    var response = await http.get((Uri.parse("https://official-joke-api.appspot.com/jokes/random")));
    return response;
  }
}
