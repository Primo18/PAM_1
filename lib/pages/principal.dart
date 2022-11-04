import 'package:democlase3/dto/mensajesDTO.dart';
import 'package:democlase3/pages/login.dart';
import 'package:democlase3/pages/users.dart';
import 'package:democlase3/pages/new_msg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  late Future<List<MensajesDto>> futureMensaje;

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Súper  Mensajes"),
        ),
        drawer: const NavigationDrawer(),
        body: const Center(
          child: Text("Login Success"),
        ));
  }*/

  Widget cuadro1(MensajesDto obj) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        height: 250,
        padding: const EdgeInsets.all(2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(color: Colors.black)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Fecha: ${obj.fecha}",
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              "User: ${obj.login}",
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              "Titulo: ${obj.titulo}",
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              "Descripcion: ${obj.texto}",
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    futureMensaje = getMensajes();
  }

  Future<List<MensajesDto>> getMensajes() async {
    final response = await http
        .get(Uri.parse('https://fcfab46d0f16.sa.ngrok.io/api/mensajes'));

    if (response.statusCode == 200) {
      print(response.body);

      return mensajesDtoFromJson(response.body);
    } else {
      throw Exception('Error (capaz se cayo la api)');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: const Text("Mensajes"),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: FutureBuilder<List<MensajesDto>>(
                  future: futureMensaje,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      List<Widget> lista = [];
                      if (snapshot.data != null) {
                        for (var element in snapshot.data!) {
                          lista.add(cuadro1(element));
                        }
                        return Column(
                          children: lista,
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    return const CircularProgressIndicator();
                  }))),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const NewMsg()));
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.send)));
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

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
              //Navigator.of(context).popUntil(((route) => route.isFirst));
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Login()));
            },
          )
        ],
      );
}
