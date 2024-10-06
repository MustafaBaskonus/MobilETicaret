import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/product.dart';

class DbHelper{
  late Database _db;

  //databese var mı ? yoksa initializeDb vassıtası ile oluştur.
  Future<Database> get db async{
    if(_db == null){
      _db = await initializeDb();
    }
    return _db;
  }

  //oluşturulacak db için önce paht oluşturduk.
  //sonra bu path ile bu data base i aç dedik.
  //aç derken de buveri tabanını oluşturması için  createDb fonk. kullandık.
  Future<Database> initializeDb() async {
    String? dbPath = join(await getDatabasesPath(),"etrade.db");
    var eTradeDb = await openDatabase(dbPath, version: 1, onCreate: createDb);//bir db açıyor, belki veritabanının versionu değişti
    return eTradeDb;
  }
  //veri tabanı oluşturulurken tabloları ve kolonları oluşturması için sql komutu yazdık.
  void createDb(Database db, int version) async {
    await db.execute("Create table products(id integer primary key , name text, description text, unitPrice integer)");
  }






  //database bize liste dönecek, biz ürün listesi olarak istiyoruz
  Future<List<Product>> getProducts() async{
    Database db = await this.db;
    var result = await db.query("products");
    return List.generate(result.length, (i){
      return Product.fromObject(result[i]);
    });
  }

  //ekleme gibi işlem yapınca int değer döner sql
  Future<int> insert(Product product) async {
    Database db = await this.db;
    var result = await db.insert("products",product.toMap());
    return result;
  }
  Future<int> delete(int? id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from products where id = $id");
    return result;
  }
  Future<int> update(Product product) async {
    Database db = await this.db;
    var result = await db.update("products", product.toMap(),where: "id= ?", whereArgs: [product.id]);
    return result;
  }
}