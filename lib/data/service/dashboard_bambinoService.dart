import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/models/diagnosi.dart';
import 'package:software_analista/domain/models/risultatoTest.dart';

class Dashboard_bambinoService{
  final String baseUrl = 'http://localhost:3000';

  Future<List<Test>> getTestByBambino(String? codiceGioco) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/tentativi-test/tentativi/$codiceGioco'),
    );
    debugPrint('GET /tentativi/$codiceGioco');
    debugPrint('STATUS: ${response.statusCode}');
    debugPrint('BODY: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Errore caricamento bambini');
    }

    final List data = jsonDecode(response.body);
    return data.map((e) => Test.fromJson(e)).toList();
  }

  Future<Bambino> salvaDiagnosi(
    String? bambinoId,
    Diagnosi diagnosi,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/bambini/$bambinoId/diagnosi'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'testo': diagnosi.testo,
        'livelloGravita': diagnosi.livelloGravita.name,
        'note': diagnosi.note,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Errore salvataggio diagnosi');
    }

    return Bambino.fromJson(jsonDecode(response.body));
  }

  Future<Bambino> eliminaDiagnosi(String? bambinoId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/bambini/$bambinoId/diagnosi'),
    );

    if (response.statusCode != 200) {
      throw Exception('Errore eliminazione diagnosi');
    }

    return Bambino.fromJson(jsonDecode(response.body));
  }
}
