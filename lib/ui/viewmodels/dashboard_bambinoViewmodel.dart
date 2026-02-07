import 'package:flutter/foundation.dart';
import 'package:software_analista/data/repository/dashboard_bambinoRepository.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/models/risultatoTest.dart';

class DashboardBambinoViewModel extends ChangeNotifier {
  final Bambino _bambino;
  bool _isLoading = true;
  final DashboardBambinorepository _repository;
  List<Test> _tests = []; /// tutti i test del bambino

  DashboardBambinoViewModel({
    required Bambino bambino,
    required DashboardBambinorepository repository
    }) : _bambino = bambino,
          _repository = repository;
  

  // ===============================
  // GETTERS
  // ===============================

  Bambino get bambino => _bambino;
  bool get isLoading => _isLoading;
  List<Test> get tests => _tests;

  // ===============================
  // INIT
  // ===============================

  Future<void> initialize() async {
    _setLoading(true);

    try {
      // Carica tutti i test del bambino dalla repository
      _tests = await _repository.getTestByBambino(_bambino.codiceGioco);
    } catch (e) {
      print("Errore caricamento test: $e");
      _tests = [];
    }

    _setLoading(false);
  }

  Future<void> reloadTests() async {
    _setLoading(true);
    _tests = await _repository.getTestByBambino(_bambino.codiceGioco);
    _setLoading(false);
  }

  List<Map<String, dynamic>> getProgressiChartData() {
  if (_tests.isEmpty) return [];

  return _tests.map((test) {
    return {
      /// ASSE X → nome del livello del percorso
      'test': test.nome,

      /// ASSE Y → punteggio ottenuto in quel livello
      'punteggio': test.domandeCorrette,
    };
  }).toList();
}


  // ===============================
  // UTILS
  // ===============================

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
