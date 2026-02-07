import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
}
