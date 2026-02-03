import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_analista/ui/viewmodels/home_viewmodel.dart';
import 'package:software_analista/ui/widgets/Datacard.dart';
import 'package:software_analista/ui/widgets/Sidebar.dart';
import 'package:software_analista/ui/widgets/Topbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Row(
              children: [
                // Sidebar fissa
                Sidebar(),

                // Contenuto principale
                Expanded(
                  child: Column(
                    children: [
                      // Top bar
                      TopBar(),

                      // Contenuto centrale
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: vm.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : GridView.count(
                                  crossAxisCount: 4,
                                  childAspectRatio: 2,
                                  crossAxisSpacing: 24,
                                  mainAxisSpacing: 24,
                                  children: [
                                    DataCard(
                                      icon: Icons.child_care,
                                      title: 'Bambini',
                                      value: vm.numeroBambini.toString(),
                                      color: Colors.blue,
                                    ),
                                    DataCard(
                                      icon: Icons.male,
                                      title: 'Maschi',
                                      value: vm.numeroMaschi.toString(),
                                      color: Colors.green,
                                    ),
                                    DataCard(
                                      icon: Icons.female,
                                      title: 'Femmine',
                                      value: vm.numeroFemmine.toString(),
                                      color: Colors.pink,
                                    ),
                                    DataCard(
                                      icon: Icons.alt_route,
                                      title: 'Percorsi',
                                      value: '0',           //vm.numeroPercorsi.toString(),
                                      color: Colors.orange,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
