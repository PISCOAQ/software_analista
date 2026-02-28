import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:software_analista/domain/models/risultatoTest.dart';

class HomeService{
  final String baseUrl = 'http://localhost:3000';

  Future<List<Test>> getAllTentativi() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/tentativi-test/tutti'),
    );

    if (response.statusCode != 200) {
      throw Exception('Errore caricamento tentativi');
    }

    final List data = jsonDecode(response.body);
    return data.map((e) => Test.fromJson(e)).toList();
  }
}