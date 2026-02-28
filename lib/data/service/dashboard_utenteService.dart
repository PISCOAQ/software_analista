import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:software_analista/domain/models/utente.dart';
import 'package:software_analista/domain/models/diagnosi.dart';
import 'package:software_analista/domain/models/risultatoTest.dart';

class Dashboard_utenteService{
  final String baseUrl = 'http://localhost:3000';

  Future<List<Test>> getTestByUtente(String? codiceGioco) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/tentativi-test/tentativi/$codiceGioco'),
    );
    

    if (response.statusCode != 200) {
      throw Exception('Errore caricamento utenti');
    }

    final List data = jsonDecode(response.body);
    return data.map((e) => Test.fromJson(e)).toList();
    
  }

  Future<Utente> salvaDiagnosi(
    String? utenteId,
    Diagnosi diagnosi,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/utenti/$utenteId/diagnosi'),
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

    return Utente.fromJson(jsonDecode(response.body));
  }

  Future<Utente> eliminaDiagnosi(String? utenteId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/utenti/$utenteId/diagnosi'),
    );

    if (response.statusCode != 200) {
      throw Exception('Errore eliminazione diagnosi');
    }

    return Utente.fromJson(jsonDecode(response.body));
  }


  Future<String> downloadExcel(String utenteId, String nomeUtente) async {
    final url = 'http://localhost:3000/export/excel/$utenteId';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception(
        'Errore download Excel: ${response.statusCode}',
      );
    }

      // Ottieni la cartella Documenti o temporanea
      final dir = await getDownloadsDirectory()
         ?? await getApplicationDocumentsDirectory();

      final filePath = '${dir.path}/report_$nomeUtente.xlsx';

      // Scrivi il file su disco
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      print('File salvato in: $filePath');

      // Apri il file (opzionale)
      OpenFile.open(filePath);

      return filePath;
  }
}
