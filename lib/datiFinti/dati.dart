import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/models/percorso.dart';
import 'package:software_analista/domain/models/progressoPercorso.dart';
import 'package:software_analista/domain/enums/sesso.dart';

final percorsoEmotivo = Percorso(id: 'p1', numNodi: 20, nome: 'percorso1', descrizione: 'descrizione', dataInizio: DateTime(2024, 12,24));
final percorsoMotorio = Percorso(id: 'p2', numNodi: 15, nome: 'percorso2', descrizione: 'descrizione', dataInizio: DateTime(2025, 11,15));
final percorsoGiocoso = Percorso(id: 'p3', numNodi: 10, nome: 'percorso3', descrizione: 'descrizione', dataInizio: DateTime(2024, 08,20));




Percorso? getPercorsoById(String id) {
  final percorsi = [
    percorsoEmotivo,
    percorsoMotorio,
    percorsoGiocoso,
  ];

  return percorsi.firstWhere(
    (p) => p.id == id,
  );
}

        