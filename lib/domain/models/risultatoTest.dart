import 'package:software_analista/domain/enums/tipoTest.dart';
import 'package:software_analista/domain/models/domandaTest.dart';


class Test {
  final String id;
  final String bambinoId;
  final String? percorsoId; // per ora opzionale
  final String nome;
  final TipoTest tipo;
  //final String metodoInterazione;
  final double tempoMedioReazione;
  final String movimentoMouse;
  final bool superato;
  final int domandeCorrette;
  final int domandeTotali;
  final List<DomandaTest> domande;

  Test({
    required this.id,
    required this.bambinoId,
    this.percorsoId,
    required this.nome,
    required this.tipo,
    //required this.metodoInterazione,
    required this.tempoMedioReazione,
    required this.movimentoMouse,
    required this.superato,
    required this.domandeCorrette,
    required this.domandeTotali,
    required this.domande,
  });
  
  double get percentuale =>
      domandeTotali == 0 ? 0 : (domandeCorrette / domandeTotali) * 100;

  /*double get tempoMedioReazione {
    if (domande.isEmpty) return 0;
    return domande
            .map((d) => d.tempoReazione)
            .reduce((a, b) => a + b) /
        domande.length;
  }*/




  factory Test.fromJson(Map<String, dynamic> json) {
    final domandeJson = json['domande'] as List<dynamic>? ?? [];
    return Test(
      id: json['id'],
      bambinoId: json['bambinoId'],
      percorsoId: json['percorsoId'],
      nome: json['nomeTest'],
      tipo: json['tipo'],
      superato: json['superato'],
      tempoMedioReazione: json['tempoMedioReazione'],
      movimentoMouse: json['movimentoMouse'],
      domandeCorrette: json['domandeCorrette'],
      domandeTotali: json['domandeTotali'],
      domande: domandeJson
          .map((d) => DomandaTest.fromJson(d as Map<String, dynamic>))
          .toList(),
    );
  }
}
