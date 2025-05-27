import 'package:flutter/material.dart';
import 'package:practica3_1/basedatos/BD.dart';
import 'package:practica3_1/widget/BaseDatos.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  final TextEditingController usuarioC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  void Agregar() async {
    String usu = usuarioC.text;
    String pas = passwordC.text;

    if (usu.isNotEmpty && pas.isNotEmpty) {
      bool respuesta = await BD().ValidarUsuario(usu, pas);
      if (respuesta) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BaseDatos()),
        );
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Bienvenido'),
              content: Text('Pasele pa dentro usuario guapo'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      } else {
        usuarioC.clear();
        passwordC.clear();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('yo se que no es el usuario'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      }
      usuarioC.clear();
      passwordC.clear();
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('agregregar datos'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bases de datos',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          height: 400,
          color: const Color.fromARGB(255, 195, 195, 195),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 19,
                ),
                TextField(
                  controller: usuarioC,
                  decoration: InputDecoration(
                    hintText: 'Escribe el usuario',
                  ),
                ),
                TextField(
                  controller: passwordC,
                  decoration: InputDecoration(
                    hintText: 'Escribe el password',
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: Agregar,
                    child: Text('Aceptar'),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
