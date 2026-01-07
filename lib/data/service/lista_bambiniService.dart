import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../domain/models/bambino.dart';

class ListaBambiniService {
  final String baseUrl = 'http://localhost:3000';

  Future<List<Bambino>> listaBambini() async {
    print('➡️ Chiamata API lista bambini');
    final response = await http.get(
      Uri.parse('$baseUrl/bambino'),
    );

    print('⬅️ Status: ${response.statusCode}');
    print('⬅️ Body: ${response.body}');


    if (response.statusCode != 200) {
      throw Exception('Errore caricamento bambini');
    }

    final List data = jsonDecode(response.body);
    return data.map((e) => Bambino.fromJson(e)).toList();
  }
}
