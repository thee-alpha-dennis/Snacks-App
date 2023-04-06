import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ConnectionSQLiteService {
  ConnectionSQLiteService._();

  static ConnectionSQLiteService? _instance;

  static ConnectionSQLiteService get instance {
    _instance ??= ConnectionSQLiteService._();
    return _instance!;
  }


  static const DATABASE_NAME = 'snacks.db';
  static const DATABASE_VERSION = 1;
  Database? _db;

  Future<Database> get db => _openDatabase();

  Future<Database> _openDatabase() async {
    sqfliteFfiInit();
    String databasePath = await getDatabasesPath();
    String path = join(await databasePath, DATABASE_NAME);


    if (_db == null) {
      var _db = await  openDatabase(path,version: 1, onCreate: (Database database, int version) async {
        await createUserTable(database);
        },);
      return _db;
    }
    return _db!;
  }
  static Future<void> createUserTable(Database database) async {
    await database.execute(SnackItemTableCreate.CREATE_TABLE);

  }



}
class SnackItemTableCreate {
  static const CREATE_TABLE = '''
        CREATE TABLE SnackItem (
          SnackItemId INTEGER PRIMARY KEY AUTOINCREMENT,
          SnackItemName VARCHAR(100),
          Price REAL,
          ImagePath TEXT
          )
        ''';

}

