import 'package:software_analista/domain/models/percorso.dart';

class ProgressoPercorso {
  final Percorso percorso;
  final int nodiCompletati;

  ProgressoPercorso({
    required this.percorso,
    required this.nodiCompletati,
  });

  /*double calcolaPercentuale(int numNodi){
    if (numNodi == 0) return 0;
    return nodiCompletati/numNodi * 100;
  }*/


}