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
          Create table usuarios(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          usuario TEXT NOT NULL,
          password TEXT NOT NULL
          )
''');
    });
  }

  Future<int> insertarUsuario(String usuario, String password) async {
    final db = await database;

    return await db.insert('usuarios', {
      'usuario': usuario,
      'password': password,
    });
  }

  Future<List<Map<String, dynamic>>> obtenerUsuario() async {
    final db = await database;

    return await db.query('usuarios');
  }

  Future<int> EliminarUsuario(int id) async {
    final db = await database;
    return await db.delete('usuarios ', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> ModificarUsuario(int id, String nu, String np) async {
    final db = await database;
    return await db.update('usuarios ', {'usuario': nu, 'password': np},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> ValidarUsuario(String nu, String np) async {
    final db = await database;
    List<Map<String, dynamic>> respuesta = await db.query('usuarios',
        where: 'usuario = ? and password = ?', whereArgs: [nu, np]);
    return respuesta.isNotEmpty;
  }
}
