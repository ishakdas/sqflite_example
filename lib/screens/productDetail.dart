import 'package:flutter/material.dart';
import 'package:sqlite_denemeler/db/dbhelper.dart';
import 'package:sqlite_denemeler/model/product.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);
  @override
  State<StatefulWidget> createState() => ProductDetailState(product);
}

Dbhelper dbHelper = new Dbhelper();
enum Chocie { Delete, Update }

class ProductDetailState extends State {
  Product product;
  ProductDetailState(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail for ${product.name}"),
        actions: <Widget>[
          PopupMenuButton<Chocie>(
            onSelected: select,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Chocie>>[
                  PopupMenuItem<Chocie>(
                    child: Text("Delete Product"),
                    value: Chocie.Delete,
                  ),
                  PopupMenuItem<Chocie>(
                    child: Text("Update Product"),
                    value: Chocie.Update,
                  )
                ],
          )
        ],
      ),
      body: Center(
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.add_shopping_cart),
                title: Text(product.name),
                subtitle: Text(product.desc),
              ),
              Text("${product.name} ürünün fiyatı : ${product.price}"),
              ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text("Sepete Ekle"),
                      onPressed: () {
                        AlertDialog alertDialog = new AlertDialog(
                          title: Text("Success"),
                          content: Text("${product.name} adden to cart"),
                        );
                        showDialog(
                            context: context, builder: (_) => alertDialog);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void select(Chocie choie) async {
    int result;
    switch (choie) {
      case Chocie.Delete:
        Navigator.pop(context, true);
        result = await dbHelper.delete(product.id);
        if (result != 0) {
          AlertDialog alertDialog = new AlertDialog(
            title: Text("Success"),
            content: Text("Delete prodeduct: ${product.name}"),
          );
          showDialog(context: context, builder: (_) => alertDialog);
        }
        break;
      default:
    }
  }
}
