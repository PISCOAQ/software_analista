import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/utente.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ListaUtentiService {
  static final String baseUrl =
      dotenv.env['API_URL'] ?? "http://localhost:3000";

  Future<List<Utente>> listaUtenti() async {
    final response = await http.get(Uri.parse('$baseUrl/utente'));
    if (response.statusCode != 200) {
      throw Exception('Errore caricamento utenti');
    }

    final List data = jsonDecode(response.body);
    return data.map((e) => Utente.fromJson(e)).toList();
  }

  Future<void> deleteUtenti(List<String> userIds) async {
    final response = await http.post(
      Uri.parse('$baseUrl/utenti/delete'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"userIds": userIds}),
    );

    if (response.statusCode != 200) {
      throw Exception("Errore eliminazione utenti");
    }
  }
}
