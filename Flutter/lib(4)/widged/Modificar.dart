import 'package:flutter/material.dart';
import 'package:qr2/basedatos/BGHelper.dart';

class Modificar extends StatefulWidget {
  final String codigo;
  final String nombre;
  final double precio;

  const Modificar({
    Key? key,
    required this.codigo,
    required this.nombre,
    required this.precio,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Modificar();
  }
}

class _Modificar extends State<Modificar> {
  late TextEditingController nombreController;
  late TextEditingController precioController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.nombre);
    precioController = TextEditingController(text: widget.precio.toString());
  }

  void guardarCambios() async {
    String nuevoNombre = nombreController.text;
    double nuevoPrecio = double.tryParse(precioController.text) ?? 0;

    await BDHelper()
        .actualizarProducto(widget.codigo, nuevoNombre, nuevoPrecio);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Modificar Producto',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(155, 0, 0, 0),
      ),
      backgroundColor: const Color.fromARGB(255, 209, 238, 245),
      body: Center(
        child: Card(
          color: Colors.blue.shade100,
          margin: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Código: ${widget.codigo}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nombreController,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: precioController,
                    decoration: InputDecoration(
                      labelText: 'Precio',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: guardarCambios,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 170, 192, 230),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child:
                        const Text('Guardar', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
