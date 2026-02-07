import 'package:software_analista/domain/enums/extensions_scuola.dart';
import 'package:software_analista/domain/enums/extensions_titoloStudio.dart';
import 'package:software_analista/domain/enums/scuola.dart';
import 'package:software_analista/domain/enums/titoloStudio.dart';
import 'package:software_analista/domain/models/progressoPercorso.dart';
import 'package:software_analista/domain/enums/sesso.dart';

class Bambino{
    final String? id;
    final String nome;
    final String cognome;
    final DateTime dataDiNascita;
    final Sesso sesso;
    final String? email;
    final String? numTelefono;
    final Scuole scuolaFrequentata;
    final TitoloStudio titoloStudio;
    final ProgressoPercorso? progressoBambino;
    final List<ProgressoPercorso>? percorsiAssegnati;
    final String? codiceGioco;

    Bambino({
      this.id,
      required this.nome,
      required this.cognome,
      required this.dataDiNascita,
      required this.sesso,
      this.email,
      this.numTelefono,
      required this.scuolaFrequentata,
      required this.titoloStudio,
      this.progressoBambino,
      this.percorsiAssegnati,
      this.codiceGioco,
  });

  // 🔹 JSON → Dart
  factory Bambino.fromJson(Map<String, dynamic> json) {
    return Bambino(
      id: json['_id'],
      nome: json['nome'],
      cognome: json['cognome'],
      dataDiNascita: DateTime.parse(json['dataNascita']),
      sesso: Sesso.values.firstWhere(
        (e) => e.name == json['sesso'],
      ),
      email: json['email'],
      numTelefono: json ['telefono'],
      scuolaFrequentata: ScuolaExtension.fromApiValue(json['scuolaFrequentata']),
      titoloStudio: TitoloStudioExtension.fromApiValue(json['titoloStudio']),
      codiceGioco: json['codiceGioco'],
    );
  }

  // 🔹 Dart → JSON
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'cognome': cognome,
      'dataNascita': dataDiNascita.toIso8601String(),
      'sesso': sesso.name,
      'email': email,
      'telefono':numTelefono,
      'scuolaFrequentata':scuolaFrequentata.name,
      'titoloStudio': titoloStudio.name,
    };
  }

  

}
