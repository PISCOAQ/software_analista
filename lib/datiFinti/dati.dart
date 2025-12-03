import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/models/percorso.dart';
import 'package:software_analista/domain/models/progressoPercorso.dart';
import 'package:software_analista/domain/models/sesso.dart';

final percorsoEmotivo = Percorso(id: 'p1', numNodi: 20, nome: 'percorso1', descrizione: 'descrizione', dataInizio: DateTime(2024, 12,24));
final percorsoMotorio = Percorso(id: 'p2', numNodi: 15, nome: 'percorso2', descrizione: 'descrizione', dataInizio: DateTime(2025, 11,15));
final percorsoGiocoso = Percorso(id: 'p3', numNodi: 10, nome: 'percorso3', descrizione: 'descrizione', dataInizio: DateTime(2024, 08,20));

final List<Bambino> bambiniFinti = [
  Bambino(
    id: '100',
    nome: 'Giacomo',
    cognome: 'Rossi',
    dataDiNascita: DateTime(2019, 5, 12),
    sesso: Sesso.maschio,
    progressiBambino: [
      ProgressoPercorso(percorso: percorsoEmotivo, nodiCompletati: 2),
      ProgressoPercorso(percorso: percorsoMotorio, nodiCompletati: 5),
    ]),
    Bambino(
      id: '101',
      nome: 'Sofia',
      cognome: 'Verdi',
      dataDiNascita: DateTime(2020, 05, 12),
      sesso: Sesso.femmina,
      progressiBambino: [
        ProgressoPercorso(percorso: percorsoGiocoso, nodiCompletati: 9)
      ])
];
        