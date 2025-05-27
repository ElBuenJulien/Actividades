import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BD {
  static final BD _instance = BD._internal();
  factory BD() => _instance;

  Database? _database;

  BD._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initBD();
    return _database!;
  }

  Future<Database> _initBD() async {
    String path = join(await getDatabasesPath(), 'usuarios.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
          Create table productos(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          producto TEXT NOT NULL,
          precio TEXT NOT NULL,
          cantidad TEXT NOT NULL
          )
''');
    });
  }

  Future<int> insertarProductos(
      String usuario, String password, String cantidad) async {
    final db = await database;

    return await db.insert('productos', {
      'producto': usuario,
      'precio': password,
      'cantidad': cantidad,
    });
  }

  Future<List<Map<String, dynamic>>> obtenerProducto() async {
    final db = await database;

    return await db.query('productos');
  }

  Future<int> EliminarProducto(int id) async {
    final db = await database;
    return await db.delete('productos ', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> ModificarProducto(int id, String nu, String np, String nc) async {
    final db = await database;
    return await db.update('productos ', {'producto': nu, 'precio': np},
        where: 'id = ?', whereArgs: [id]);
  }
  /*
  Future<bool> ValidarUsuario(String nu, String np) async {
    final db = await database;
    List<Map<String, dynamic>> respuesta = await db.query('productos',
        where: 'producto = ? and precio = ?', whereArgs: [nu, np]);
    return respuesta.isNotEmpty;
  }
  */
}
