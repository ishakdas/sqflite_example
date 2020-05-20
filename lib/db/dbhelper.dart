import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite_denemeler/model/product.dart';

class Dbhelper {
  String tblProduct = "Products";
  String colId = "Id";
  String colDesc = "Desc";
  String colPrice = "Price";
  String colName = "Name";
  static final Dbhelper _dbhelper = Dbhelper._internal();
  Dbhelper._internal();
  factory Dbhelper() {
    return _dbhelper;
  }
  static Database _db;
  Future<Database> get db async {
    
      _db = await initializeDb();
    
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory directory =
        await getApplicationDocumentsDirectory(); //Android ve iostaki klasörü getirir.
    String path = directory.path + "sqetr.db";
    var dbetlade = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbetlade;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        "Create table $tblProduct($colId integer primary key, $colName text," +
            "$colDesc text, $colPrice int)");
  }

  Future<int> insert(Product product) async {
    Database db = await this.db;
    var result = await db.insert(tblProduct, product.toMap());
    return result;
  }

  Future<int> update(Product product) async {
    Database db = await this.db;
    var result = await db.update(tblProduct, product.toMap(),
        where: "$colId=?", whereArgs: [product.id]);
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("Delete from $tblProduct where $colId=$id");
    return result;
  }

  Future<List> getProducts() async {
    Database db = await this.db;
    var result = await db.rawQuery("Select * from $tblProduct");
    return result;
  }
}
