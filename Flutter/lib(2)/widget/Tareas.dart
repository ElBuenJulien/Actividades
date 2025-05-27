import 'package:flutter/material.dart';
import 'package:practica3_4/widget/Agregar.dart';
import 'package:practica3_4/widget/Mostrar.dart';

class Tareas extends StatefulWidget {
  const Tareas({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Tareas();
  }
}

class _Tareas extends State<Tareas> {
  int seleccionindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tareas',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: seleccionindex == 0 ? Agregar() : Mostrar(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_work),
            label: 'Agregar Tarea',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_work_outlined),
            label: 'Mostrar tareas',
          ),
        ],
        currentIndex: seleccionindex,
        selectedItemColor: Colors.blue,
        onTap: (Index) {
          setState(() {
            seleccionindex = Index;
          });
        },
      ),
    );
  }
}
