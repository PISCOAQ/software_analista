import 'package:flutter/foundation.dart';
import 'package:software_analista/domain/models/utente.dart';
import 'package:software_analista/domain/models/percorso.dart';
import 'package:software_analista/data/repository/assegna_percorsoRepository.dart';
import 'package:software_analista/domain/models/percorsoAssegnato.dart';
import 'package:software_analista/domain/models/progressoPercorso.dart';

class AssegnaPercorsoViewModel extends ChangeNotifier {
  final AssegnaPercorsoRepository _repository;

  Utente? _utenteSelezionato;
  Percorso? _percorsoSelezionato;
  bool _isLoading = false;
  String? errore;

  AssegnaPercorsoViewModel(this._repository);

  // ===============================
  // GETTERS
  // ===============================
  Utente? get utente => _utenteSelezionato;
  Percorso? get percorso => _percorsoSelezionato;
  bool get isLoading => _isLoading;

  List<PercorsoAssegnato> get percorsiAssegnati =>
      _utenteSelezionato?.percorsiAssegnati ?? [];

  // ===============================
  // SELEZIONE
  // ===============================

  void selezionaUtente(Utente u) {
    _utenteSelezionato = u;
    notifyListeners();
  }

  void selezionaPercorso(Percorso p) {
    _percorsoSelezionato = p;
    notifyListeners();
  }

  // ===============================
  // AZIONI
  // ===============================

  /// Conferma l'assegnazione del percorso all'utente
  Future<void> confermaAssociazione() async {
  _setLoading(true);

  try {
    final utenteAggiornato =
        await _repository.assegnaPercorso(
          _utenteSelezionato!.id,
          _percorsoSelezionato!.id,
          _percorsoSelezionato!.nome,
        );

    _utenteSelezionato = utenteAggiornato;

  } catch (e) {
    errore = 'Errore durante assegnazione percorso: $e';
  }

  _setLoading(false);
  notifyListeners();
}


  /// Rimuove un percorso assegnato dal utente
  /*Future<void> rimuoviPercorso(Percorso p) async {
    if (_utenteSelezionato == null) return;

    _setLoading(true);

    try {
      final utenteAggiornato = await _repository.rimuoviPercorso(
        _utenteSelezionato!.id,
        p.idEsterno,
      );

      _utenteSelezionato = utenteAggiornato;
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
