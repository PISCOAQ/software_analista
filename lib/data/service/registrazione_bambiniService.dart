import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../domain/models/bambino.dart';

class RegistrazioneBambinoService {
  final String baseUrl = 'http://localhost:3000';

  Future<Bambino> creaBambino(Bambino bambino) async {
    final response = await http.post(
      Uri.parse('$baseUrl/bambino'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bambino.toJson()), // usa il metodo toJson del modello
    );

    if (response.statusCode == 201) {
      final map = jsonDecode(response.body);
      return Bambino.fromJson(map['nuovoBambino']);
    } else{
      throw Exception(
        'Errore creazione bambino: ${response.statusCode} ${response.body}',
      );
    }
  }
}
