import 'package:flutter/foundation.dart';
import 'package:software_analista/data/repository/dashboard_bambinoRepository.dart';
import 'package:software_analista/domain/enums/tipoTest.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/models/diagnosi.dart';
import 'package:software_analista/domain/models/risultatoTest.dart';

class DashboardBambinoViewModel extends ChangeNotifier {
  Bambino _bambino;
  bool _isLoading = false;
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
  List<Test> get testPre =>
    tests.where((t) => t.tipoTest == TipoTest.pre).toList();

  List<Test> get testPost =>
    tests.where((t) => t.tipoTest == TipoTest.post).toList();


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
      'test': test.nomeTest,

      /// ASSE Y → punteggio ottenuto in quel livello
      'punteggio': test.domandeCorrette,
    };
  }).toList();
}


  Future<void> inserisciDiagnosi(Diagnosi diagnosi) async {
    _setLoading(true);

  try {
    final bambinoAggiornato = await _repository.salvaDiagnosi(bambino.id, diagnosi);
    _bambino = bambinoAggiornato;

    notifyListeners();
    

  } catch (e) {
    debugPrint('Errore durante il salvataggio della diagnosi: $e');
  }


  _setLoading(false);
  notifyListeners();
}

Future<void> modificaDiagnosi(Diagnosi diagnosi) async {
  await inserisciDiagnosi(diagnosi);
}

Future<void> eliminaDiagnosi() async {
  _setLoading(true);
  notifyListeners();

  try {
    final Bambino bambinoAggiornato = await _repository.eliminaDiagnosi(bambino.id);
    _bambino = bambinoAggiornato;
  } catch (e) {
    debugPrint('Errore durante eliminazione diagnosi: $e');
  }

  _setLoading(false);
  notifyListeners();
}

Future<void> esportaExcel(String bambinoId, String nome) async {
    try {
      _setLoading(true);

      await _repository.downloadExcel(
        _bambino.id!,
        _bambino.nome,
      );
    } catch (e) {
      debugPrint("Errore nel dowload del file excel: $e");
    } finally {
      _setLoading(false);
    }
  }

  // ===============================
  // UTILS
  // ===============================

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
