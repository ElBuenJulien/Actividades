import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr2/basedatos/BGHelper.dart';
import 'package:qr2/widged/Mostar.dart';

class Qr extends StatefulWidget {
  const Qr({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Qr();
  }
}

class _Qr extends State<Qr> {
  TextEditingController nombreC = TextEditingController();
  TextEditingController precioC = TextEditingController();
  String nombre = "", precio = "";
  bool ventana = false;
  void MostrarDatos(String numeros) {
    showDialog(
      context: context,
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.qr_code_2_rounded, color: Colors.blueGrey),
              SizedBox(width: 10),
              Text(
                'Nuevo Producto',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth < 400 ? screenWidth * 0.85 : 400,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Código detectado:',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 4),
                  Text(
                    numeros,
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: nombreC,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.drive_file_rename_outline),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: precioC,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Precio',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          actions: [
            ElevatedButton.icon(
              onPressed: () async {
                nombre = nombreC.text;
                precio = precioC.text;
                if (nombre.isNotEmpty && precio.isNotEmpty) {
                  double pre = double.parse(precio);
                  await BDHelper().insertarProducto(numeros, nombre, pre);
                  nombreC.clear();
                  precioC.clear();

                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Producto Guardado')),
                  );
                }
              },
              icon: Icon(Icons.save),
              label: Text('Guardar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
              ),
            ),
          ],
        );
      },
    ).then((_) {
      setState(() {
        ventana = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lector de Qr',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Mostar()),
              );
            },
            icon: Icon(Icons.list),
          )
        ],
        backgroundColor: Colors.blueGrey,
      ),
      body: MobileScanner(
        onDetect: (captute) {
          if (ventana == false) {
            final codigo = captute.barcodes.first;
            final String numeros = codigo.rawValue ?? 'sin codigo';
            if (numeros != 'sin codigo') {
              ventana = true;
              MostrarDatos(numeros);
            }
          }
        },
      ),
    );
  }
}
