import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

class YelpService {
  Future<List<dynamic>> searchRestaurants(String location) async {
    final response = await http.get(
      Uri.parse('${AppConfig.apiBaseUrl}/search?location=$location'),
      headers: {
        'Authorization': 'Bearer ${AppConfig.apiKey}', // Utilisez la clé API ici
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['businesses'];
    } else {
      throw Exception('Échec du chargement des restaurants : ${response.reasonPhrase}');
    }
  }
}
