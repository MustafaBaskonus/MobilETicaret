import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';

import '../models/product.dart';

class ProductDetail extends StatefulWidget{
  late Product product;
  ProductDetail(this.product);
  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }


  
}
//enumlar class lar gibi yapılardır  bu yüzden sınıfların dışında yazılır.
enum Options {delete , update}

class _ProductDetailState extends State{
  late Product product;
  _ProductDetailState(this.product);
  var dbHelper = DbHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün detayı ${product.name}"),
        backgroundColor: Colors.tealAccent,
        actions: [
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder:(BuildContext context)=> <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Sil"),
              ),
              PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Güncelle"),
              )
            ],
          )
        ],
      ),
      body: buildProductDetail(),
      
    );
  }

  buildProductDetail () {
    
  }

  void selectProcess(Options options) async{
    switch(options){
      case Options.delete:
        dbHelper.delete(product.id);
        Navigator.pop(context,true);
        break;
      case Options.update:
        dbHelper.update(product);
        Navigator.pop(context,true);
      default:
    }
  }
}