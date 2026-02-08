import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_analista/data/repository/assegna_percorsoRepository.dart';
import 'package:software_analista/data/service/assegna_percorsoService.dart';
import 'package:software_analista/ui/screens/HomeScreen.dart';
import 'package:software_analista/ui/viewmodels/lista_bambiniViewmodel.dart';
import 'package:software_analista/ui/viewmodels/lista_percorsiViewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AssegnaPercorsoService>(
          create: (_) => AssegnaPercorsoService(),
        ),
        ProxyProvider<AssegnaPercorsoService, AssegnaPercorsoRepository>(
          update: (_, service, __) => AssegnaPercorsoRepository(service),
        ),
        ChangeNotifierProvider(
          create: (_) => lista_bambiniViewmodel()..loadBambini(),
          ),
        ChangeNotifierProvider(
          create: (_) => lista_percorsiViewModel()
          ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Software Analista',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}