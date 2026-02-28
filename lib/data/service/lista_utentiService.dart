import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/utente.dart';

class ListaUtentiService {
  final String baseUrl = 'http://localhost:3000';

  Future<List<Utente>> listaUtenti() async {
    final response = await http.get(
      Uri.parse('$baseUrl/utente'),
    );
    if (response.statusCode != 200) {
      throw Exception('Errore caricamento utenti');
    }

    final List data = jsonDecode(response.body);
    return data.map((e) => Utente.fromJson(e)).toList();
  }
}
