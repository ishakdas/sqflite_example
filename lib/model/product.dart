class Product {
  int _id;
  String _name;
  String _desc;
  double _price;
  Product(this._name, this._desc, this._price);
  Product.withID(this._id, this._name, this._desc, this._price);
  int get id => _id;
  String get name => _name;
  String get desc => _desc;
  double get price => _price;
  set name(String value) {
    if (value.length >= 2) {
      _name = value;
    }
  }

  set desc(String value) {
    if (value.length >= 10) {
      _desc = value;
    }
  }

  set price(double value) {
    if (value > 0) {
      _price = value;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = _name;
    map["desc"] = _desc;
    map["price"] = _price;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Product.fromObject(dynamic o) {
    this._id = o["Id"];
    this._name = o["Name"];
    this._desc = o["Desc"];
    this._price = double.tryParse(o["Price"].toString());
  }
}
