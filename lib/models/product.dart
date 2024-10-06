class Product {
  int? id;
  String? name;
  String? description;
  double? unitPrice;

  //parametreler belli bir sırada gelmese bile eşleştirilir.
  Product({this.id, this.name, this.description, this.unitPrice});

  Product.withId({this.name, this.description, this.unitPrice});


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"]= name;
    map["description"]= description;
    map["unitPrice"]= unitPrice;
    if(id != null){
      map["id"]= id;
    }
    return map;
  }


  Product.fromObject(Map<String, dynamic> o) {
    this.id = o["id"];
    this.name = o["name"];
    this.description = o["description"];
    this.unitPrice = o["unitPrice"] is int ? o["unitPrice"].toDouble() : o["unitPrice"];
  }

}
