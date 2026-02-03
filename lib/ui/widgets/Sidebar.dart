import 'package:flutter/material.dart';
import 'package:software_analista/ui/screens/HomeScreen.dart';
import 'package:software_analista/ui/screens/lista_bambiniScreen.dart';
import 'package:software_analista/ui/screens/lista_percorsiScreen.dart';
import 'package:software_analista/ui/screens/selezione_bambinoScreen.dart';
import 'package:software_analista/ui/widgets/Sidebar_item.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: Colors.black,
            width: 2.5, // 👈 linea di separazione
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Text(
            'PISCO',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 40),

          SidebarItem(
            icon: Icons.home,
            label: 'Home',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => HomeScreen()),
              );
            },
          ),
          SidebarItem(
            icon: Icons.person,
            label: 'Utenti',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Lista_bambiniScreen()),
              );
            },
          ),
          SidebarItem(
            icon: Icons.list,
            label: 'Percorsi',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Lista_percorsiScreen()),
              );
            },
          ),
          SidebarItem(
            icon: Icons.route,
            label: 'Assegnazione',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => SelezioneBambinoScreen()),
              );
            },
          ),
          SidebarItem(
            icon: Icons.settings,
            label: 'Impostazioni',
          ),
        ],
      ),
    );
  }
}
