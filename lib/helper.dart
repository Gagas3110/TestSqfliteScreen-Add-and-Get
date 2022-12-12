import 'package:sqflite/sqflite.dart' as hiSql;

class HaiSql {
//createDatabase

  static Future<void> generateTable(hiSql.Database database) async {
    await database.execute("""
CREATE TABLE identitas(
id INTEGER PRIMARY KEY
AUTOINCREMENT NOT NULL,
username TEXT,
provinsi TEXT
)
""");
  }

  static Future<hiSql.Database> db() async {
    return hiSql.openDatabase('identitas.db', version: 1,
        onCreate: (hiSql.Database database, int version) async {
      await generateTable(database);
    });
  }

// create data

  static Future<int> createData(String username, String provinsi) async {
    final db = await HaiSql.db();
    final data = {'username': username, 'provinsi': provinsi};
    return await db.insert('identitas', data);
  }

// get data

  static Future<List<Map<String, dynamic>>> getProvinsi() async {
    final db = await HaiSql.db();
    return db.query('identitas');
  }
}
