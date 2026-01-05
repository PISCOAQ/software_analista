import 'package:software_analista/domain/models/progressoPercorso.dart';
import 'package:software_analista/domain/models/sesso.dart';

class Bambino{
    final String id;
    final String nome;
    final String cognome;
    final DateTime dataDiNascita;
    final Sesso sesso;
    final ProgressoPercorso? progressoBambino;
    final String? percorsoId;

    Bambino({
      required this.id,
      required this.nome,
      required this.cognome,
      required this.dataDiNascita,
      required this.sesso,
      this.percorsoId,
      this.progressoBambino,
  });

  // 🔹 JSON → Dart
  factory Bambino.fromJson(Map<String, dynamic> json) {
    return Bambino(
      id: json['id'],
      nome: json['nome'],
      cognome: json['cognome'],
      dataDiNascita: DateTime.parse(json['dataDiNascita']),
      sesso: Sesso.values.firstWhere(
        (e) => e.name == json['sesso'],
      ),
    );
  }

  // 🔹 Dart → JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cognome': cognome,
      'dataDiNascita': dataDiNascita.toIso8601String(),
      'sesso': sesso.name,
    };
  }

  

}
