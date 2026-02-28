import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:software_analista/domain/models/utente.dart';

class AssegnaPercorsoService {
  final String baseUrl = 'http://localhost:3000';

  /// Assegna un percorso a un utente
  Future<Utente> assegnaPercorso({
    required String? utenteId,
    required String percorsoIdEsterno,
    required String nomePercorso,
  }) async {
    final url = Uri.parse('$baseUrl/utenti/$utenteId/assegna-percorso');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'percorsoIdEsterno': percorsoIdEsterno,
        'nomePercorso': nomePercorso,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return Utente.fromJson(json['utente']);
    } else {
      throw Exception(
        'Errore assegnazione percorso (${response.statusCode})',
      );
    }
  }
}