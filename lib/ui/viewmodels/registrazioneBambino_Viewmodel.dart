import 'package:flutter/material.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/models/percorso.dart';
import 'package:software_analista/domain/models/sesso.dart';
import 'package:uuid/uuid.dart';

class Registrazionebambino_Viewmodel extends ChangeNotifier{
  String nome = '';
  String cognome = '';
  DateTime? dataNascita;
  Sesso sesso = Sesso.maschio;
  Percorso? percorso;
  bool isLoading = true;
  String? errorMessage;

  Registrazionebambino_Viewmodel(){
    _initForm();
  }

    Future<void> _initForm() async{
    await Future.delayed(const Duration(milliseconds: 300)); // Simula caricamento
    isLoading = false;
    nome = '';
    cognome = '';
    sesso = Sesso.maschio;
    dataNascita = null;
    errorMessage = null;

    notifyListeners();
  }

  void updateNome( String value){
    nome = value;
    notifyListeners();
  }
  void updateCognome (String value){
    cognome = value;
    notifyListeners();
  }
  void updateDataNascita(DateTime value){
    dataNascita = value;
    notifyListeners();
  }
  void updateSesso(Sesso? value){
    sesso = value!;
    notifyListeners();
  }


  Bambino? creaBambino() {
    if (nome.isEmpty || cognome.isEmpty || dataNascita == null || sesso == null) {
    errorMessage = 'Compila tutti i campi obbligatori';
    notifyListeners(); // va bene farlo qui perché è triggerato da un pulsante
    return null;
  }

  errorMessage = null;
  notifyListeners();

  return Bambino(
    id: const Uuid().v4(), // genera un ID univoco
    nome: nome,
    cognome: cognome,
    dataDiNascita: dataNascita!,
    sesso: sesso,
  );
  }
}