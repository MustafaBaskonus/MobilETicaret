import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';

import '../models/product.dart';

class ProductAdd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }
}

class ProductAddState extends State{
  var dbHelper =DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Ürün Ekle"),
        backgroundColor: Colors.redAccent,
      ),
      body:  Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
        children: <Widget>[
          buildNameField(),buildDescriptionField(),buildUnitPriceField(),buildSaveButton()
        ],
      ),
    )
    );
  }



  TextField buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "ürün adı"),
      controller: txtName,
    );
  }
  buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "ürün açıklaması"),
      controller: txtDescription,
    );
  }
  buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Fiyatı"),
      controller: txtUnitPrice,
    );
  }

  buildSaveButton() {
    return FloatingActionButton(
      child: Text("Ekle"),
      onPressed: (){
        addProduct();
    }
    );
  }

  void addProduct() async{
    var result = await dbHelper.insert(Product(name:txtName.text,description:txtDescription.text,unitPrice:double.tryParse(txtUnitPrice.text)));
    Navigator.pop(context,result);//pop bir önceki sayfaya git demek.
  }
}