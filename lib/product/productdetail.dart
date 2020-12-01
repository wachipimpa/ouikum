import 'package:flutter/material.dart';
import '../datamodel/product.dart';

class ProductDetail extends StatefulWidget{
  Product product ;
  ProductDetail({Key key, @required this.product}) :super (key: key);
  @override
  _ProductDetail createState()=> _ProductDetail();
}
class _ProductDetail extends State<ProductDetail>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){

          },
        ),
        title: Text('${widget.product.ProductName}'),
      ),
      body: Container(
        child: Column(
          children: [

          ],
        )
      ),
    );
  }

}