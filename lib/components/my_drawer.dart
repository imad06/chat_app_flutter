import 'package:chaty/services/auth/auth_service.dart';
import 'package:chaty/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logout() async {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
             DrawerHeader(
             child: Center(
               child: Icon(
                Icons.message,
                color: Theme.of(context).colorScheme.primary,
                size: 40,),
           ),
         ),
         Padding(
           padding: const EdgeInsets.only(left:25.0),
           child: ListTile(
            title:const  Text("H O M E"),
            leading: Icon(Icons.home, color: Theme.of(context).colorScheme.primary),
            onTap: () {
              Navigator.pop(context);
            },
           ),
         ),

         Padding(
           padding: const EdgeInsets.only(left:25.0),
           child: ListTile(
            title: const Text("S E T T I N G S"),
            leading:  Icon(Icons.settings, color: Theme.of(context).colorScheme.primary),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>const SettingsPage()));
            },
             ),
         ),

          ],),
          
         Padding(
           padding: const EdgeInsets.only(left:25.0),
           child: ListTile(
            title: const Text("L O G O U T"),
            leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.primary),
            onTap: logout,
             ),
         )
    // Ajoute d'autres widgets ici si besoin
      ],
     ),
    );
  }
}

       