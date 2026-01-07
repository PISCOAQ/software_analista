import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/bambino.dart';

class RegistrazioneBambinoService {
  final String baseUrl = 'http://localhost:3000';

  Future<void> creaBambino(Bambino bambino) async {
    final response = await http.post(
      Uri.parse('$baseUrl/bambino'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bambino.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Errore creazione bambino');
    }
  }
}
