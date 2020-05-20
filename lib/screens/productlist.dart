import 'package:flutter/material.dart';
import 'package:sqlite_denemeler/db/dbhelper.dart';
import 'package:sqlite_denemeler/model/product.dart';
import 'package:sqlite_denemeler/screens/ProductAdd.dart';
import 'package:sqlite_denemeler/screens/productDetail.dart';

class ProductList extends StatefulWidget {
  State<StatefulWidget> createState() => ProductlistState();
}

class ProductlistState extends State {
  Dbhelper dbHelper = new Dbhelper();
  List<Product> products;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (products == null) {
      products = new List<Product>();
      getDate();
    }
    return Scaffold(
      body: productListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){goToProdact();},
        tooltip: "Add New Product",
        child: Icon(Icons.add),
      ),
    );
  }

  ListView productListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext contect, int position) {
        return Card(
          color: Colors.amberAccent,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text("A"),
            ),
            title: Text(this.products[position].name),
            subtitle: Text(this.products[position].desc),
            onTap: () {
              gotoDetail(this.products[position]); 
            }, //Tıklanınca
          ),
        );
      },
    );
  }

  void getDate() {
    var dbFuture = dbHelper.initializeDb();
    dbFuture.then((reslut) {
      var productsFuture = dbHelper.getProducts();
      productsFuture.then((data) {
        List<Product> producsData = new List<Product>();
        count = data.length;
        for (var i = 0; i < count; i++) {
          producsData.add(Product.fromObject(data[i]));
          setState(() {
            products = producsData;
            count = count;
          });
        }
      });
    });
  }

  void gotoDetail(Product product) async {
   bool result= await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductDetail(product)));
        if (result!=null) {
          if(result)
          getDate();
        }
  }


void goToProdact()async{
bool result= await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));
        if (result!=null) {
          if(result)
          getDate();
        }

}  

}
