import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopping_cart_app/model/cart_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _database;
  static const String? dbName = 'cart';
  Future<Database?> get database async {
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, '$dbName.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $dbName(id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE, productName TEXT,  productPrice INTEGER, quantity INTEGER,  image TEXT,rating TEXT,discountPercentage TEXT)');
  }

  Future<bool> insert(Cart cart) async {
    try {
      var dbClient = await database;
      var man = await dbClient?.query('$dbName');
      var data = man?.map((e) => Cart.fromMap(e)).toList();
      var exist = data!.where((element) => element.id == cart.id).toList();
      if (exist.isNotEmpty) {
        // await updateQuantity(cart);
        return false;
      }
      // await dbClient?.execute('SELECT ID FROM CARTS WHERE ID=?', [cart.id]);
      await dbClient!.insert('$dbName', cart.toMap());
      return true;
    } catch (e) {
      throw '$e';
    }
  }

  Future<List<Cart>> getCartList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('$dbName');
    return queryResult.map((result) => Cart.fromMap(result)).toList();
  }

  Future<int> deleteCartItem(int id) async {
    var dbClient = await database;
    return await dbClient!.delete('$dbName', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateQuantity(Cart cart) async {
    var dbClient = await database;
    return await dbClient!.update('$dbName', cart.quantityMap(),
        where: "productId = ?", whereArgs: [cart.productId]);
  }

  // Future<List<Cart>> getCartId(int id) async {
  //   var dbClient = await database;
  //   final List<Map<String, Object?>> queryIdResult =
  //       await dbClient!.query('$dbName', where: 'id = ?', whereArgs: [id]);
  //   return queryIdResult.map((e) => Cart.fromMap(e)).toList();
  // }
}
