import 'package:flutter/material.dart';
import 'package:sqlite_denemeler/db/dbhelper.dart';
import 'package:sqlite_denemeler/model/product.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProductAddState();
}

class ProductAddState extends State {
  TextEditingController txtName = new TextEditingController();
  TextEditingController txtPrice = new TextEditingController();
  TextEditingController txtDesc = new TextEditingController();
  Dbhelper dbHelper = new Dbhelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add a new Product"),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
          child: Column(children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Name"),
              controller: txtName,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Description"),
              controller: txtDesc,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Price"),
              controller: txtPrice,
            ),
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                save();
              },
            )
          ]),
        ));
  }

  void save() async {
int result=await dbHelper.insert(
        Product(txtName.text, txtDesc.text, double.tryParse(txtPrice.text)));//nsert başarılı olursa eklenecek ürünün son ID numarasını geri döndürecek
if(result!=0)
  Navigator.pop(context,true);
  }
}
