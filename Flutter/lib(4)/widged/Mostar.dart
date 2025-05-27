import 'package:flutter/material.dart';
import 'package:qr2/basedatos/BGHelper.dart';
import 'package:qr2/widged/Modificar.dart';

class Mostar extends StatefulWidget {
  const Mostar({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Mostrar();
  }
}

class _Mostrar extends State<Mostar> {
  List<Map<String, dynamic>> productos = [];

  void cargarDatos() async {
    final valores = await BDHelper().obtenerProductos();
    setState(() {
      productos = valores;
    });
  }

  void EnviarAEliminar(String codigo) {
    showDialog(
      context: context,
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 175, 200, 204),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: const EdgeInsets.all(20),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  'Confirmar eliminación',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth < 400 ? screenWidth * 0.8 : 400,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '¿Estás seguro de que deseas eliminar el producto con el siguiente código?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    codigo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          actions: [
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.cancel, color: Colors.grey),
              label: Text('Cancelar'),
            ),
            TextButton.icon(
              onPressed: () {
                Eliminar(codigo);
                Navigator.pop(context);
              },
              icon: Icon(Icons.delete, color: Colors.red),
              label: Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> Eliminar(String codi) async {
    await BDHelper().EliminarProducto(codi);
    cargarDatos();
  }

  void initState() {
    super.initState();
    cargarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mostrar Datos'),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: const Color.fromARGB(255, 225, 242, 245),
      body: productos.isEmpty
          ? Center(
              child: Text('No hay productos'),
            )
          : ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[
                    index]; // productos[index]['dato que quieras'] uso sin metodo adicional
                return Card(
                  color: Color.fromARGB(192, 175, 200, 204),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue.shade300,
                          child: Icon(Icons.inventory_2, color: Colors.white),
                        ),
                        const SizedBox(width: 16),
                        //final producto = productos[index]; puntero de listas metodo adicional para insertar los elemento de la lista

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Código: ${producto['codigo']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text('Nombre: ${producto['nombre']}'),
                              Text('Precio: \$${producto['precio']}'),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                EnviarAEliminar(producto['codigo']);
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Modificar(
                                      codigo: producto['codigo'],
                                      nombre: producto['nombre'],
                                      precio: producto['precio'],
                                    ),
                                  ),
                                ).then((_) => cargarDatos());
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
/*
void EnviarAEliminar(String codigo) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 10),
            Text('Confirmar eliminación'),
          ],
        ),
        content: Text(
          '¿Estás seguro de que deseas eliminar el producto con código:\n\n**$codigo**?',
          style: TextStyle(fontSize: 16),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.cancel),
            label: Text('Cancelar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade600,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Eliminar(codigo);
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete),
            label: Text('Eliminar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
          ),
        ],
      );
    },
  );
}

*/
