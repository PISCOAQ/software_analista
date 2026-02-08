import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:software_analista/domain/models/bambino.dart';

class AssegnaPercorsoService {
  final String baseUrl = 'http://localhost:3000';

  /// Assegna un percorso a un bambino
  Future<Bambino> assegnaPercorso({
    required String? bambinoId,
    required String percorsoIdEsterno,
    required String nomePercorso,
  }) async {
    final url = Uri.parse('$baseUrl/bambini/$bambinoId/assegna-percorso');

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
      return Bambino.fromJson(json['bambino']);
    } else {
      throw Exception(
        'Errore assegnazione percorso (${response.statusCode})',
      );
    }
  }
}