import 'package:flutter/material.dart';
import 'package:practica3_1/basedatos/BD.dart';
import 'package:practica3_1/widget/mostrardatos.dart';

class BaseDatos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BaseDatos();
  }
}

class _BaseDatos extends State<BaseDatos> {
  final TextEditingController usuarioC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  void Agregar() async {
    String usu = usuarioC.text;
    String pas = passwordC.text;

    if (usu.isNotEmpty && pas.isNotEmpty) {
      await BD().insertarUsuario(usu, pas);
      usuarioC.clear();
      passwordC.clear();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Bien'),
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
              children: [
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
                  child: FloatingActionButton(
                    onPressed: Agregar,
                    child: Text('Aceptar'),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MostrarDatos(),
                        ),
                      );
                    },
                    child: Text('Mostrar datos'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
