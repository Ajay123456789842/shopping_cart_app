
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:shopping_cart_app/model/cart_model.dart';

class DBHelper {
  static Database? _database;

  Future<Database?> get database async {
    _database = await initDatabase();
    return _database;
   
  }

  initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'carts.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE carts(id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE, productName TEXT,  productPrice INTEGER, quantity INTEGER,  image TEXT,rating TEXT,discountPercentage TEXT)'); 
  }

  Future<Cart> insert(Cart cart) async {
    var dbClient = await database;
    await dbClient!.insert('carts', cart.toMap());
    return cart;
  }

  Future<List<Cart>> getCartList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('carts');
    return queryResult.map((result) => Cart.fromMap(result)).toList();
  }

  Future<int> deleteCartItem(int id) async {
    var dbClient = await database;
    return await dbClient!.delete('carts', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateQuantity(Cart cart) async {
    var dbClient = await database;
    return await dbClient!.update('carts', cart.quantityMap(),
        where: "productId = ?", whereArgs: [cart.productId]);
  }

  // Future<List<Cart>> getCartId(int id) async {
  //   var dbClient = await database;
  //   final List<Map<String, Object?>> queryIdResult =
  //       await dbClient!.query('carts', where: 'id = ?', whereArgs: [id]);
  //   return queryIdResult.map((e) => Cart.fromMap(e)).toList();
  // }
}
