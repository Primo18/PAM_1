import 'package:flutter/material.dart';
import 'package:democlase3/dto/mensajesDTO.dart';
import 'package:http/http.dart' as http;
import 'package:democlase3/pages/principal.dart';
import 'package:democlase3/pages/login.dart';
import 'dart:convert';

Future<http.Response> crearMensaje(
    String login, String titulo, String texto) async {
  return await http.post(
    Uri.parse('https://fcfab46d0f16.sa.ngrok.io/api/mensajes'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'login': login,
      'titulo': titulo,
      'texto': texto,
    }),
  );
}

class NewMsg extends StatelessWidget {
  const NewMsg({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Crear mensaje';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const Padding(
          padding: EdgeInsets.all(32.0),
          child: MyCustomForm(),
        ),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  TextEditingController titulo = TextEditingController();
  TextEditingController texto = TextEditingController();
  Future<http.Response>? _futureMensaje;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: titulo,
            decoration: const InputDecoration(
                hintText: "T??tulo", border: OutlineInputBorder()),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese un t??tulo';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: texto,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
                hintText: "Texto", border: OutlineInputBorder()),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  setState(() {
                    _futureMensaje = crearMensaje(
                        emailController.text, titulo.text, texto.text);
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Principal()));
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
