import 'package:cool_alert/cool_alert.dart';
import 'package:democlase3/pages/principal.dart';
import 'package:democlase3/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final TextEditingController emailController = TextEditingController();

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //final TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> validarDatos(String email, String password) async {
    final response = await LoginService().validar(email, password);

    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Principal()));
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'Usuario o contraseña incorrecta',
        loopAnimation: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 30);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ingrese sus datos"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: 400,
                height: 200,
                child: Image.asset('assets/canasta_verduras.png',
                    fit: BoxFit.fill),
              ),
              sizedBox,
              TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      hintText: "Ingrese su email",
                      labelText: "Email",
                      suffixIcon:
                          const Icon(Icons.email, color: Colors.black54))),
              sizedBox,
              TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      hintText: "Ingrese su contraseña",
                      labelText: "Contraseña",
                      suffixIcon: const Icon(Icons.remove_red_eye))),
              sizedBox,
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: const StadiumBorder()),
                      onPressed: () {
                        if (emailController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Ingrese un email válido",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          validarDatos(
                              emailController.text, passwordController.text);
                        }
                      },
                      child: const Text("Ingresar")))
            ],
          ),
        ),
      ),
    );
  }
}
