import 'package:sqflite/sqflite.dart';
import '../models/cartitemmodel.dart';
import 'connectiobstodb.dart';

class CartDBHelper {
  final ConnectionSQLiteService _dbService = ConnectionSQLiteService.instance;

  Future<Database> get database async {
    final db = await ConnectionSQLiteService.instance.db;

    return db;
  }

  Future<void> createTable(Database db) async {
    final List<Map<String, dynamic>> tables = await db.query("sqlite_master",
        where: "type = 'table' AND name = 'cart'");
    if (tables.isEmpty) {
      await db.execute(
          'CREATE TABLE cart(SnackItemId INTEGER PRIMARY KEY AUTOINCREMENT, '
              'SnackItemName TEXT, Price REAL,'
              ' Quantity INTEGER, ImagePath TEXT)');
    }
  }

  // inserting data into the table
  Future<Cart> insert(Cart cart) async {
    final Database db = await _dbService.db;
    var dbClient = db;
    dbClient = await database;
    await createTable(dbClient);
    await dbClient.insert('cart', cart.toMap());
    return cart;
  }

  // getting all the items in the list from the database
  Future<List<Cart>> getCartList() async {
    final Database db = await _dbService.db;
    var dbClient = db;
    dbClient = await database;
    final List<Map<String, Object?>> queryResult = await dbClient.query('cart');
    return queryResult.map((result) => Cart.fromMap(result)).toList();
  }

  Future<int> updateQuantity(Cart cart) async {
    final Database db = await _dbService.db;
    var dbClient = db;
    dbClient = await database;
    return await dbClient.update('cart', cart.toMap(),
        where: "SnackItemId = ?", whereArgs: [cart.snackId]);
  }

  // deleting an item from the cart screen
  Future<int> deleteCartItem(int id) async {
    final Database db = await _dbService.db;
    var dbClient = db;
    dbClient = await database;
    return await dbClient
        .delete('cart', where: 'SnackItemId = ?', whereArgs: [id]);
  }

  Future<void> clearCart() async {
    final Database db = await _dbService.db;
    var dbClient = db;
    dbClient = await database;
    await dbClient.delete('cart');
  }


}