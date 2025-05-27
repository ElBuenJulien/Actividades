import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Lector extends StatefulWidget {
  const Lector({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Lector();
  }
}

class _Lector extends State<Lector> {
  bool ventana = false;
  void MostrarDatos(String numeros) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Dato Qr'),
          content: Center(
            child: Text('Codigo: $numeros'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  ventana = false;
                });
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    ).then((_) => ventana = false);
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
        backgroundColor: Colors.blueGrey,
      ),
      body: MobileScanner(
        onDetect: (captute) {
          if (ventana == false) {
            final codigo = captute.barcodes.first;
            final String numeros = codigo.rawValue ?? 'sin codigo';
            if (numeros != 'sin codigo') {
              ventana = false;
              MostrarDatos(numeros);
            }
          }
        },
      ),
    );
  }
}
