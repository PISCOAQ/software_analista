import 'package:flutter/foundation.dart';
import 'package:software_analista/domain/models/percorso.dart';
import 'package:software_analista/datiFinti/dati.dart';

class lista_percorsiViewModel extends ChangeNotifier {
  List<Percorso> _percorsi = [];
  bool _isLoading = true;

  lista_percorsiViewModel() {
    _init();
  }

  List<Percorso> get percorsi => _percorsi;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> _init() async {
    isLoading = true;
    notifyListeners();

    // Simula un piccolo delay come se stessimo caricando da API
    await Future.delayed(const Duration(milliseconds: 300));

    _percorsi = [
      percorsoEmotivo,
      percorsoMotorio,
      percorsoGiocoso,
    ];

    isLoading = false;
    notifyListeners();
  }

  // Metodo opzionale per filtrare i percorsi
  List<Percorso> filtraPercorsi(String query) {
    return _percorsi
        .where((p) => p.nome.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
