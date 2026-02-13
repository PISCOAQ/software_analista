import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/models/diagnosi.dart';
import 'package:software_analista/domain/models/risultatoTest.dart';

class Dashboard_bambinoService{
  final String baseUrl = 'http://localhost:3000';

  Future<List<Test>> getTestByBambino(String? codiceGioco) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/tentativi-test/tentativi/$codiceGioco'),
    );
    

    if (response.statusCode != 200) {
      throw Exception('Errore caricamento bambini');
    }

    final List data = jsonDecode(response.body);
    print(data);
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


  Future<String> downloadExcel(String bambinoId, String nomeBambino) async {
    final url = 'http://localhost:3000/export/excel/$bambinoId';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception(
        'Errore download Excel: ${response.statusCode}',
      );
    }

      // Ottieni la cartella Documenti o temporanea
      final dir = await getDownloadsDirectory()
         ?? await getApplicationDocumentsDirectory();

      final filePath = '${dir.path}/report_$nomeBambino.xlsx';

      // Scrivi il file su disco
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      print('File salvato in: $filePath');

      // Apri il file (opzionale)
      OpenFile.open(filePath);

      return filePath;
  }
}
