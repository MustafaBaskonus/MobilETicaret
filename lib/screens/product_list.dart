import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';

import 'package:sqflite_demo/screens/product_detail.dart';import '../models/product.dart';
import 'product_add.dart';
import 'product_detail.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State<ProductList> {
  var dbhelper = DbHelper();
  late List<Product> products = []; // Boş liste ile başlattık
  int productCount = 0;

  @override
  void initState() {
    super.initState(); // super.initState() eklenmeli
    getProducts(); // Ürün listesini dönen metot
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Listesi"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gotoProductAdd();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  buildProductList() {
    return ListView.builder(
      itemCount: productCount,
      itemBuilder: (BuildContext context, int position) {
        // Card widget'ı
        return Card(
          color: Colors.cyan,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black12,
              child: Text("P"),
            ),
            title: Text(products[position].name as String),
            subtitle: Text(products[position].description as String),
            onTap: () { goToDetail(this.products[position]);},
          ),
        );
      },
    );
  }

  // Ürün ekleme sayfasına geçiş ve geri dönen değere göre listeyi güncelleme
  void gotoProductAdd() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductAdd()),
    );

    // Null kontrolü yaparak varsayılan olarak `false` değeri kullanıyoruz.
    if (result != null ) {
      if(result == true){
        getProducts(); // Ürün listesini güncelle
      }
    }
  }

  // Ürün listesini dönen metot
  void getProducts() async {
    var productsFuture = dbhelper.getProducts();
    productsFuture.then((data) {
      setState(() {
        this.products = data;
        this.productCount = data.length;
      });
    });
  }

  //ürün detayı
  void goToDetail(Product product) async{
      bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(product)));
      if(result != null){
        if(result){
          getProducts();
        }
      }

  }



}
