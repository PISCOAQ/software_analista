import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/utente.dart';

class RegistrazioneUtenteService {
  final String baseUrl = 'http://localhost:3000';

  Future<Utente> creaUtente(Utente utente) async {
    final response = await http.post(
      Uri.parse('$baseUrl/utente'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(utente.toJson()),
    );

    if (response.statusCode == 201) {
      final map = jsonDecode(response.body);
      return Utente.fromJson(map['nuovoUtente']);
    } else{
      throw Exception(
        'Errore creazione utente: ${response.statusCode} ${response.body}',
      );
    }
  }
}
