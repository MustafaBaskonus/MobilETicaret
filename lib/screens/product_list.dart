import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';

import '../models/product.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State {
  var dbhelper = DbHelper();
  late List<Product> products;
  int productCount = 0;

  //uygulama ilk açıldığında liste boş data gelince sayfaya yüklensin
  @override
  void initState(){
    var productsFuture =dbhelper.getProducts();
    productsFuture.then((data){
      this.products= data ;
    });
    //state içinde initState diye bir fonk var onuda çalıştır.
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Listesi"),
          backgroundColor: Colors.purple,
      ),
      body: buildProductList(),
    );
  }

  buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position) {
          //card conteynır gibi çalışır.
          return Card(
            color: Colors.cyan,
            elevation: 2.0,//büyüklük
            child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.black12,child: Text("p"),),
              title: Text(this.products[position].name as String),
              subtitle: Text(this.products[position].description as String),
              onTap: (){},
            ),
          );
        });
  }
}
