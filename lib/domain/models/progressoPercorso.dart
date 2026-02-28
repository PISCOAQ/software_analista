class ProgressoPercorso {
  final String percorsoId; // da sostituire con percorsoId quando avrò l'API
  final int nodiCompletati;

  ProgressoPercorso({
    required this.percorsoId,
    required this.nodiCompletati,
  });

  /*double calcolaPercentuale(int numNodi){
    if (numNodi == 0) return 0;
    return nodiCompletati/numNodi * 100;
  }*/


}