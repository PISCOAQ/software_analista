class Percorso{
  final String id;
  final int numNodi;
  final String nome;
  final String descrizione;
  final DateTime dataInizio;
  final DateTime? dataFIne;

  Percorso({
    required this.id,
    required this.numNodi,
    required this.nome,
    required this.descrizione,
    required this.dataInizio,
    this.dataFIne,
  });

}