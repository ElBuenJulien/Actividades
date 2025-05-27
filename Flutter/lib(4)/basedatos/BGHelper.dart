import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BDHelper {
  static final BDHelper _instance = BDHelper._internal();
  factory BDHelper() => _instance;

  BDHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initBD();
    return _database!;
  }

  Future<Database> _initBD() async {
    String path = join(await getDatabasesPath(), 'Abarrotera.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
          Create table producto(
          codigo TEXT  PRYMARY KEY,
          nombre TEXT NOT NULL,
          precio REAL NOT NULL
          )
''');
    });
  }

  Future<int> insertarProducto(
      String codigo, String nombre, double precio) async {
    final db = await database;
    return db.insert('producto', {
      'codigo': codigo,
      'nombre': nombre,
      'precio': precio,
    });
  }

  Future<int> EliminarProducto(String codigo) async {
    final db = await database;
    return await db
        .delete('producto', where: 'codigo = ?', whereArgs: [codigo]);
  }

  Future<List<Map<String, Object?>>> obtenerProductos() async {
    final db = await database;
    return await db.query('producto');
  }

  Future<int> actualizarProducto(
      String codigo, String nombre, double precio) async {
    final db = await database;
    return await db.update(
      'producto',
      {'nombre': nombre, 'precio': precio},
      where: 'codigo = ?',
      whereArgs: [codigo],
    );
  }
}
