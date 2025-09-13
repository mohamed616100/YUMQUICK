import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:yumquick/features/Home/data/models/Top_Rated_Product.dart';

class ProductDBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "products.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY,
            name TEXT,
            description TEXT,
            imagePath TEXT,
            price REAL,
            rating REAL,
            bestSeller INTEGER,
            category TEXT,
            isFavorite INTEGER
          )
        ''');
      },
    );
  }

  static Future<int> insertProduct(Products product) async {
    final db = await database;
    return await db.insert(
      'products',
      {
        'id': product.id,
        'name': product.name,
        'description': product.description,
        'imagePath': product.imagePath,
        'price': product.price,
        'rating': product.rating,
        'bestSeller': product.bestSeller,
        'category': product.category?.toString(),
        'isFavorite': (product.isFavorite ?? false) ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  static Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await database;
    return await db.query("products");
  }


  static Future<int> deleteProduct(int id) async {
    final db = await database;
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> updateProduct(Products product) async {
    final db = await database;
    return await db.update(
      'products',
      {
        'name': product.name,
        'description': product.description,
        'imagePath': product.imagePath,
        'price': product.price,
        'rating': product.rating,
        'bestSeller': product.bestSeller,
        'category': product.category?.toString(),
        'isFavorite': (product.isFavorite ?? false) ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }
}
