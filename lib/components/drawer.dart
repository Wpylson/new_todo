import 'package:flutter/material.dart';
import 'package:new_todo/components/drawer_tile.dart';
import 'package:new_todo/screens/settings_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //Header
          const DrawerHeader(
            child: Icon(
              Icons.book,
              size: 100,
            ),
          ),

          //Notes tile
          DrawerTile(
            title: "Notas",
            leading: const Icon(Icons.home),
            onTap: () => Navigator.pop(context),
          ),

          //Settings tile
          DrawerTile(
            title: "Configurações",
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
