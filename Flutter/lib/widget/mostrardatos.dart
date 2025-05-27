import 'package:flutter/material.dart';
import 'package:practica3_1/basedatos/BD.dart';

class MostrarDatos extends StatefulWidget {
  const MostrarDatos({super.key});

  @override
  _MostrarDatos createState() => _MostrarDatos();
}

class _MostrarDatos extends State<MostrarDatos> {
  List<Map<String, dynamic>> usuarios = [];
  @override
  void initState() {
    super.initState();
    obtenerUsuario();
  }

  void obtenerUsuario() async {
    List<Map<String, dynamic>> datos = await BD().obtenerUsuario();
    setState(() {
      usuarios = datos;
    });
  }

  void EliminarUsuario(int id, String usu) {
    print('ID: ' + usu);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar'),
          content: Text('Estas seguro \nElimiar $usu'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('NO'),
            ),
            TextButton(
              onPressed: () {
                Eliminar(id);
                Navigator.pop(context);
              },
              child: const Text('SI'),
            ),
          ],
        );
      },
    );
  }

  void Eliminar(int id) async {
    await BD().EliminarUsuario(id);
    obtenerUsuario();
  }

  void ModificarUsuario(int id, String usu, String pass) {
    TextEditingController u = TextEditingController(text: usu);
    TextEditingController p = TextEditingController(text: pass);

    print('ID: ' + usu);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modificar'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  '$id',
                  style: TextStyle(fontSize: 18),
                ),
                TextField(
                  controller: u,
                  decoration: InputDecoration(
                    labelText: '$usu',
                  ),
                ),
                TextField(
                  controller: p,
                  decoration: InputDecoration(
                    labelText: '$pass',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await BD().ModificarUsuario(id, u.text, p.text);
                obtenerUsuario();
                Navigator.pop(context);
              },
              child: const Text('Modificar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mostrar datos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: usuarios.isEmpty
          ? Center(
              child: Text('Lista vacia'),
            )
          : ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.abc_rounded),
                  title: Text(usuarios[index]['usuario']),
                  subtitle: Text(usuarios[index]['password']),
                  trailing: Wrap(
                    direction: Axis.vertical,
                    spacing: 5,
                    children: [
                      IconButton(
                        onPressed: () {
                          EliminarUsuario(usuarios[index]['id'],
                              usuarios[index]['usuario']);
                        },
                        icon: Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {
                          ModificarUsuario(
                              usuarios[index]['id'],
                              usuarios[index]['usuario'],
                              usuarios[index]['password']);
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
