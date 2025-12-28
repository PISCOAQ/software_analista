import 'package:flutter/material.dart';
import 'package:software_analista/domain/models/bambino.dart';
import 'package:software_analista/domain/models/percorso.dart';
import 'package:software_analista/domain/models/sesso.dart';
import 'package:uuid/uuid.dart';

class RegistrazionebambinoViewmodel extends ChangeNotifier{
  String nome = '';
  String cognome = '';
  DateTime? dataNascita;
  Sesso sesso = Sesso.maschio;
  Percorso? percorso;
  bool isLoading = true;
  String? errorMessage;

  RegistrazionebambinoViewmodel(){
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

  void setNome( String value) => nome = value;
  void setCognome (String value) => cognome = value;
  void setDataNascita(DateTime value) => dataNascita = value;
  void setSesso(Sesso value) => sesso = value;

  bool validateForm() {
    if (nome.isEmpty || cognome.isEmpty || dataNascita == null) {
      errorMessage = 'Compila tutti i campi obbligatori';
      notifyListeners();
      return false;
    }
    errorMessage = null;
    return true;
  }

  Bambino? creaBambino() {
    if (!validateForm()) return null;

    return Bambino(
      id: const Uuid().v4(),  // genera un ID univoco
      nome: nome,
      cognome: cognome,
      dataDiNascita: dataNascita!,
      sesso: sesso,
    );
  }
}