import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_analista/ui/screens/lista_bambiniScreen.dart';
import 'package:software_analista/ui/viewmodels/lista_bambiniViewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => lista_bambiniViewmodel()..loadBambini(),
          ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Software Analista',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const Lista_bambiniScreen(),
      ),
    );
  }
}