import 'package:flutter/material.dart';
import 'package:software_analista/datiFinti/dati.dart';
import 'package:software_analista/domain/models/bambino.dart';

class lista_bambiniViewmodel extends ChangeNotifier{
  List<Bambino> _bambini = [];
  bool _isLoading = true;

  List<Bambino> get bambini => _bambini;
  bool get isLoading => _isLoading;

  lista_bambiniViewmodel(){
    loadBambini();
  }

  Future<void> loadBambini() async{
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));
    _bambini = bambiniFinti;
    _isLoading = false;
    notifyListeners();
  }

  // Aggiunge un nuovo bambino (opzionale)
  void aggiungiBambino(Bambino nuovoBambino) {
    _bambini.add(nuovoBambino);
    notifyListeners();
  }

  // Aggiorna un bambino esistente (opzionale)
  void aggiornaBambino(Bambino bambinoAggiornato) {
    final index = _bambini.indexWhere((b) => b.id == bambinoAggiornato.id);
    if (index != -1) {
      _bambini[index] = bambinoAggiornato;
      notifyListeners();
    }
  }
}