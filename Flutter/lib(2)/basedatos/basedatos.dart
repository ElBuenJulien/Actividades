import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Basedatos {
  static final Basedatos _instance = Basedatos._internal();
  factory Basedatos() => _instance;

  Database? _database;

  Basedatos._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initBD();
    return _database!;
  }

  Future<Database> _initBD() async {
    String path = join(await getDatabasesPath(), 'Tareas.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
          Create table tarea(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          titulo TEXT NOT NULL,
          descripcion TEXT NOT NULL,
          realizada INTEGER NOT NULL
          )
''');
    });
  }

  Future<int> insertarTarea(String titulo, String descripcion) async {
    final db = await database;

    return await db.insert('tarea', {
      'titulo': titulo,
      'descripcion': descripcion,
      'realizada': 0,
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
