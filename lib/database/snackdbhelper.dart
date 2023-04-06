import 'dart:async';
import 'dart:math';
import 'package:sqflite/sqflite.dart';
import '../models/snackitemmodel.dart';
import 'connectiobstodb.dart';

class DatabaseHelper {
  final ConnectionSQLiteService _dbService = ConnectionSQLiteService.instance;
  List<Item> snacks = [
    Item(
        name: 'Butter Bread', price: 150, image: 'assets/bread.jpg',),
    Item(name: 'Coffee White', price: 200, image: 'assets/coffee.jpg', ),
    Item(
        name: 'Cookies',
        price: 925,
        image: 'assets/cookie.jpg',
        ),
    Item(name: 'Hamburger', price: 640, image: 'assets/hamburger.jpg', ),
    Item(
        name: 'Hot Hamburger', price: 570, image: 'assets/hamburger2.jpg', ),
    Item(name: 'Macarons', price: 890, image: 'assets/macarons.jpg', ),
    Item(
        name: 'Muffins',
        price: 1240,
        image: 'assets/muffins.jpg',
        ),
    Item(
        name: 'Pizza',
        price: 1500,
        image: 'assets/pizza.jpg',)
  ];
  Future<void> insertSnack(Item item) async {
    final Database db = await _dbService.db;
    await db.insert('SnackItem', item.toMap());
  }

  Future<List<Item>> getFoodItems(String query) async {
    final Database db = await _dbService.db;
      for (int index = 0; index < snacks.length; index++) {
        Item item = snacks[index];
        final existing = await db.query(
          'SnackItem',
          where: 'SnackItemName = ?',
          whereArgs: [item.name],
        );
        if (existing.isEmpty) {
          await insertSnack(Item(
            name: item.name,
            price: item.price,
            image: item.image,
          ));

      }
    }

    final List<Map<String, dynamic>> maps = await db.query('SnackItem');
    final autoarrange = List<Item>.from(List.generate(maps.length, (i) {
      return Item(
        name: maps[i]['SnackItemName'],
        price: maps[i]['Price'],
        image: maps[i]['ImagePath'],
      );
    })
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList());
    final random = Random();
    autoarrange.shuffle(random);

    return autoarrange;

  }

  Future<int?> getMenuItemId(String name) async {
    final Database db = await _dbService.db;
    final List<Map<String, dynamic>> maps = await db.query(
      'SnackItem',
      columns: ['SnackItemId'],
      where: 'SnackItemName = ?',
      whereArgs: [name],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return maps.first['SnackItemId'];
    } else {
      return null;
    }
  }
}
