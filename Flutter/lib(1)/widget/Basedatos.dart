import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practica3_2/bd/BD.dart';

class Basedatos extends StatefulWidget {
  const Basedatos({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Basedatos();
  }
}

class _Basedatos extends State<Basedatos> {
  final TextEditingController productoC = TextEditingController();
  final TextEditingController precioC = TextEditingController();
  final TextEditingController cantidadC = TextEditingController();

  List<Map<String, dynamic>> usuarios = [];

  void Agregar() async {
    String usu = productoC.text;
    String pas = precioC.text;
    String can = cantidadC.text;
    if (usu.isNotEmpty && pas.isNotEmpty && can.isNotEmpty) {
      await BD().insertarProductos(usu, pas, can);
      productoC.clear();
      precioC.clear();
      cantidadC.clear();
      obtenerProducto();
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
  void initState() {
    super.initState();
    obtenerProducto();
  }

  void obtenerProducto() async {
    List<Map<String, dynamic>> datos = await BD().obtenerProducto();
    setState(() {
      usuarios = datos;
    });
  }

  void EliminarProducto(int id, String usu) {
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
    await BD().EliminarProducto(id);
    obtenerProducto();
  }

  void ModificarUsuario(int id, String usu, String pass, String can) {
    TextEditingController u = TextEditingController(text: usu);
    TextEditingController p = TextEditingController(text: pass);
    TextEditingController c = TextEditingController(text: can);

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
                TextField(
                  controller: c,
                  decoration: InputDecoration(
                    labelText: '$can',
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
                await BD().ModificarProducto(id, u.text, p.text, c.text);
                obtenerProducto();
                Navigator.pop(context);
              },
              child: const Text('Modificar'),
            ),
          ],
        );
      },
    );
  }

  void tiket() {
    double totalSinIVA = 0;

    List<Widget> detalleProductos = [];

    for (var producto in usuarios) {
      String nombre = producto['producto'].toString();
      double precio = double.tryParse(producto['precio'].toString()) ?? 0;
      int cantidad = int.tryParse(producto['cantidad'].toString()) ?? 0;
      double subtotal = precio * cantidad;

      totalSinIVA += subtotal;

      detalleProductos.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('🛒 Producto: $nombre'),
          Text('    Precio: \$${precio.toStringAsFixed(2)}'),
          Text('    Cantidad: $cantidad'),
          Text('    Subtotal: \$${subtotal.toStringAsFixed(2)}'),
          SizedBox(height: 8),
        ],
      ));
    }

    double totalConIVA = totalSinIVA * 1.16;

    detalleProductos.addAll([
      Divider(),
      Text('💵 Total sin IVA: \$${totalSinIVA.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.bold)),
      Text('💰 Total con IVA (16%): \$${totalConIVA.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.bold)),
    ]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('🧾 Ticket de Compra'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: detalleProductos,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Aceptar'),
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
          title: Text('PRACTICA 2'),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                color: const Color.fromARGB(255, 195, 195, 195),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: productoC,
                      decoration: InputDecoration(
                        hintText: 'Escribe el usuario',
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: precioC,
                      decoration: InputDecoration(
                        hintText: 'Escribe el password',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    TextField(
                      controller: cantidadC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Escribe el usuario',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: FloatingActionButton(
                        onPressed: () async {
                          Agregar();
                          setState(() {}); // Recargar la lista al agregar
                        },
                        child: Text('Aceptar'),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          tiket();
                          setState(() {}); // Recargar la lista al agregar
                        },
                        child: Text('Aceptar'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: usuarios.isEmpty
                    ? Center(child: Text('Lista vacía'))
                    : ListView.builder(
                        itemCount: usuarios.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.shopping_cart),
                            title: Text(usuarios[index]['producto']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Precio: ${usuarios[index]['precio']}'),
                                Text(
                                    'Categoría: ${usuarios[index]['cantidad']}'),
                              ],
                            ),
                            trailing: Wrap(
                              direction: Axis.vertical,
                              spacing: 5,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    EliminarProducto(usuarios[index]['id'],
                                        usuarios[index]['producto']);
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                                IconButton(
                                  onPressed: () {
                                    ModificarUsuario(
                                      usuarios[index]['id'],
                                      usuarios[index]['producto'],
                                      usuarios[index]['precio'],
                                      usuarios[index]['cantidad'],
                                    );
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ));
  }
}
