import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practica3_4/basedatos/basedatos.dart';

class Agregar extends StatefulWidget {
  const Agregar({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Mostrar();
  }
}

class _Mostrar extends State<Agregar> {
  TextEditingController tituloC = TextEditingController();
  TextEditingController descripcionC = TextEditingController();

  void Agregar() async {
    String tit = tituloC.text;
    String des = descripcionC.text;

    if (tit.isNotEmpty && des.isNotEmpty) {
      await Basedatos().insertarTarea(tit, des);
      descripcionC.clear();
      tituloC.clear();
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
            content: Text('agregregar datos, \n Faltan datos'),
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
                TextField(
                  controller: tituloC,
                  decoration: InputDecoration(
                    hintText: 'Escribe la tarea',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z ]'),
                    ),
                  ],
                ),
                TextField(
                  controller: descripcionC,
                  decoration: InputDecoration(
                    hintText: 'Describe la tarea',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z ]'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: Agregar,
                    child: Text('Aceptar'),
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
