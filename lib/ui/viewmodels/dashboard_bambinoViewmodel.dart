import 'package:flutter/widgets.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/models/progressoPercorso.dart';

class dashboard_bambinoViewmodel extends ChangeNotifier{
  Bambino _bambino;
  bool _isLoading = true;

  dashboard_bambinoViewmodel({
    required Bambino bambino,
  }) : _bambino = bambino;

  Bambino get bambino => _bambino;
  List<ProgressoPercorso> get progressi => _bambino.progressiBambino;
  bool get isLoading => _isLoading;

  set isLoading(bool value) => _isLoading = value;

  Future<void> loadBambino(Bambino b) async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300)); // simulazione caricamento
    _bambino = b;

    isLoading = false;
    notifyListeners();
  }









  //temporaneo
  void aggiornaNodiCompletati(String percorsoNome, int nodiCompletati) {
    final index = _bambino.progressiBambino
        .indexWhere((p) => p.percorso.nome == percorsoNome);
    if (index != -1) {
      _bambino.progressiBambino[index] = ProgressoPercorso(
        percorso: _bambino.progressiBambino[index].percorso,
        nodiCompletati: nodiCompletati,
      );
      notifyListeners();
    }
  }

  double percentualeCompletata(ProgressoPercorso progresso) {
    final totaleNodi = progresso.percorso.numNodi;
    if (totaleNodi == 0) return 0.0;
    return (progresso.nodiCompletati / totaleNodi) * 100;
  }

   // Calcola percentuali per tutti i progressi
  Map<String, double> percentualiProgressi() {
    final Map<String, double> map = {};
    for (var p in _bambino.progressiBambino) {
      map[p.percorso.id] = percentualeCompletata(p);
    }
    return map;
  }
}