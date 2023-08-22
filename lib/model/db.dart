import 'package:sqflite/sqflite.dart' as sql;

class SQLUser{
  static Future<void> createTables(sql.Database database) async{
    await database.execute("""
      CREATE TABLE data(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nome TEXT,
        senha TEXT,
        email TEXT,
        contato TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    """);
  }

  static Future<sql.Database> db() async{
    return sql.openDatabase(
      "database_user.db",
      version: 1,
      onCreate: (sql.Database database, int version) async{
        await createTables(database);
      }
    );
  }

  static Future<void> createData(String nome, String senha, String email, String contato) async {
    final db = await SQLUser.db();

    final data = {'nome': nome, 'senha':senha, 'email':email, 'contato': contato};
    await db.insert('data', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    // ignore: avoid_print
    return print(db.query('data'));
  }

  static Future<List<Map<String, dynamic>>> getAllData() async{
    final db = await SQLUser.db();
    return db.query('data', orderBy: 'id');
  }
  
  static Future<List<Map<String, dynamic>>> getSingleData(int id) async{
    final db = await SQLUser.db();
    
    return db.query('data', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<void> deleteData(int id) async{
    final db = await SQLUser.db();
    try{
      await db.delete('data', where: "id= ?", whereArgs: [id]);
    } catch(e) {}
  }

}