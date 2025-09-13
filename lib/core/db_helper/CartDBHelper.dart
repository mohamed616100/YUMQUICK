import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:yumquick/features/Home/data/models/Top_Rated_Product.dart';

class CartDBHelper {
  static Database? _database;
  static const String _tableName = 'cart_items';

  // Get database instance
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize database
  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cart.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create table
  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        imagePath TEXT,
        description TEXT,
        quantity INTEGER NOT NULL DEFAULT 1
      )
    ''');
  }

  // Add item to cart or update quantity if exists
  static Future<void> addToCart({
    required int id,
    required String name,
    required double price,
    String? imagePath,
    String? description,
    int quantity = 1,
  }) async {
    final db = await database;

    // Check if item already exists
    final existing = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (existing.isNotEmpty) {
      // Update quantity
      final currentQuantity = existing.first['quantity'] as int;
      await db.update(
        _tableName,
        {'quantity': currentQuantity + quantity},
        where: 'id = ?',
        whereArgs: [id],
      );
    } else {
      // Insert new item
      await db.insert(
        _tableName,
        {
          'id': id,
          'name': name,
          'price': price,
          'imagePath': imagePath,
          'description': description,
          'quantity': quantity,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // Get all cart items
  static Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await database;
    return await db.query(_tableName);
  }

  // Update item quantity
  static Future<void> updateQuantity(int id, int quantity) async {
    final db = await database;
    if (quantity <= 0) {
      await removeFromCart(id);
    } else {
      await db.update(
        _tableName,
        {'quantity': quantity},
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }

  // Remove item from cart
  static Future<void> removeFromCart(int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Clear entire cart
  static Future<void> clearCart() async {
    final db = await database;
    await db.delete(_tableName);
  }

  // Get cart item count
  static Future<int> getCartItemCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT SUM(quantity) as total FROM $_tableName');
    return result.first['total'] as int? ?? 0;
  }

  // Add Products object to cart (easier method)
  static Future<void> addProductToCart(Products product, int quantity) async {
    await addToCart(
      id: product.id ?? 0,
      name: product.name ?? "No Name",
      price: product.price ?? 0.0,
      imagePath: product.imagePath,
      description: product.description,
      quantity: quantity,
    );
  }

  // Get total price
  static Future<double> getTotalPrice() async {
    final db = await database;
    final result = await db.rawQuery('SELECT SUM(price * quantity) as total FROM $_tableName');
    return result.first['total'] as double? ?? 0.0;
  }
}