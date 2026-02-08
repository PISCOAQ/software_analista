import 'package:flutter/foundation.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/models/percorso.dart';
import 'package:software_analista/data/repository/assegna_percorsoRepository.dart';
import 'package:software_analista/domain/models/percorsoAssegnato.dart';
import 'package:software_analista/domain/models/progressoPercorso.dart';

class AssegnaPercorsoViewModel extends ChangeNotifier {
  final AssegnaPercorsoRepository _repository;

  Bambino? _bambinoSelezionato;
  Percorso? _percorsoSelezionato;
  bool _isLoading = false;
  String? errore;

  AssegnaPercorsoViewModel(this._repository);

  // ===============================
  // GETTERS
  // ===============================
  Bambino? get bambino => _bambinoSelezionato;
  Percorso? get percorso => _percorsoSelezionato;
  bool get isLoading => _isLoading;

  List<PercorsoAssegnato> get percorsiAssegnati =>
      _bambinoSelezionato?.percorsiAssegnati ?? [];

  // ===============================
  // SELEZIONE
  // ===============================

  void selezionaBambino(Bambino b) {
    _bambinoSelezionato = b;
    notifyListeners();
  }

  void selezionaPercorso(Percorso p) {
    _percorsoSelezionato = p;
    notifyListeners();
  }

  // ===============================
  // AZIONI
  // ===============================

  /// Conferma l'assegnazione del percorso al bambino
  Future<void> confermaAssociazione() async {
  _setLoading(true);

  print(_bambinoSelezionato!.id);
  print(_percorsoSelezionato!.id);
  print(_percorsoSelezionato!.nome);


  try {
    final bambinoAggiornato =
        await _repository.assegnaPercorso(
          _bambinoSelezionato!.id,
          _percorsoSelezionato!.id,
          _percorsoSelezionato!.nome,
        );

    _bambinoSelezionato = bambinoAggiornato;

  } catch (e) {
    errore = 'Errore durante assegnazione percorso: $e';
  }

  _setLoading(false);
  notifyListeners();
}


  /// Rimuove un percorso assegnato dal bambino
  /*Future<void> rimuoviPercorso(Percorso p) async {
    if (_bambinoSelezionato == null) return;

    _setLoading(true);

    try {
      final bambinoAggiornato = await _repository.rimuoviPercorso(
        _bambinoSelezionato!.id,
        p.idEsterno,
      );

      _bambinoSelezionato = bambinoAggiornato;
      errore = null;
    } catch (e) {
      errore = 'Errore durante la rimozione del percorso';
      debugPrint('Errore rimozione percorso: $e');
    }

    _setLoading(false);
  }*/

  // ===============================
  // UTILS
  // ===============================
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
