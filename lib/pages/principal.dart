import 'package:democlase3/pages/users.dart';
import 'package:democlase3/pages/new_msg.dart';
import 'package:flutter/material.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Súper Mensajes"),
        ),
        drawer: NavigationDrawer(),
        body: const Center(
          child: Text("Login Success"),
        ));
  }
}

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[buildHeader(context), buildMenuItems(context)],
        )),
      );

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      );
  Widget buildMenuItems(BuildContext context) => Column(
        children: [
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Nuevo mensaje'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const NewMsg()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_box_outlined),
            title: const Text('Integrantes'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Integrantes()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Salir'),
            onTap: () {
              Navigator.of(context).popUntil(((route) => route.isFirst));
            },
          )
        ],
      );
}
