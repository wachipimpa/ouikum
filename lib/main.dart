import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ouikum/users/login.dart';
import 'datamodel/b2bbanner.dart';
import 'datamodel/path_url.dart';
import 'datamodel/product.dart';
import 'datamodel/affiliate.dart';
import 'datamodel/categorymenu.dart';
import 'product/productdetail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: State_MyApp(),
    );
  }
}

class State_MyApp extends StatefulWidget {
  @override
  _State_MyApp createState() => _State_MyApp();
}

class _State_MyApp extends State<State_MyApp> {
  var url = PathUrl();
  var slug_banner = 'GenAPI/gen_banner';
  var slug_newproduct = 'GenAPI/gen_productnew';
  var slug_category = 'GenAPI/gen_productcate';
  var slug_affiliate = 'GenAPI/gen_affiliate';
  var slug_product_advertisement = 'GenAPI/gen_product_advertisement';
  var slug_categorymenu = 'GenAPI/get_categorymenu';
  List<B2BBanner> b2bbanner = [];
  List<Product> b2bproduct = [];
  List<Product> productnoburn = [];
  List<Product> productorganic = [];
  List<Product> productcomunity = [];
  List<Affiliate> listaffiliate = [];
  List<Product> product_advertisement = [];
  List<CategoryMenu> catemenu = [];
  bool _saving = false;
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  _handleDrawer() {
    _key.currentState.openDrawer();
  }

  @override
  void initState() {
    _saving = true;
    loadbanner();
    loadaffiliate();
    loadproduct_advertisement();
    loadcategorymenu();
    super.initState();
  }

  loadcategorymenu() async {
    final res_category = await http.get(url.urlset + slug_categorymenu);
    final body_cate = json.decode(res_category.body);
    body_cate.forEach((item) {
      catemenu.add(CategoryMenu(
          int.parse("${item['CategoryID']}"), item['CategoryName']));
    });
  }

  loadproduct_advertisement() async {
    final res_advertis =
        await http.get(url.urlset + slug_product_advertisement);
    final advertis = json.decode(res_advertis.body);
    advertis.forEach((item) {
      product_advertisement.add(Product(
          int.parse("${item['ProductID']}"),
          item['ProductName'],
          item['ProductNameEng'],
          double.parse("${item['Price']}"),
          double.parse("${item['Price_One']}"),
          item['ProductImgPath'],item['ProductDetail']));
    });
  }

  loadaffiliate() async {
    final res_affiliate = await http.get(url.urlset + slug_affiliate);
    final affiliate = json.decode(res_affiliate.body);
    affiliate.forEach((item) {
      listaffiliate.add(Affiliate(
          int.parse("${item['affiliate_id']}"),
          item['affiliate_name'],
          item['affiliate_img1'],
          item['affiliate_img2'],
          item['affiliate_img3'],
          item['affiliate_img4'],
          item['affiliate_detail'],
          item['affiliate_create']));
    });
  }

  loadbanner() async {
    final res_banner = await http.get(url.urlset + slug_banner);
    final body_banner = json.decode(res_banner.body);
    body_banner.forEach((item) {
      b2bbanner.add(
          B2BBanner(int.parse("${item['BannerID']}"), item['BannerImgPath']));
    });
    setState(() {
      loadb2bproduct();
    });
  }

  loadb2bproduct() async {
    final res_newproduct = await http.get(url.urlset + slug_newproduct);
    final body_newproduct = json.decode(res_newproduct.body);
    body_newproduct.forEach((item) {
      b2bproduct.add(Product(
          int.parse("${item['ProductID']}"),
          item['ProductName'],
          item['ProductNameEng'],
          double.parse("${item['Price']}"),
          double.parse("${item['Price_One']}"),
          item['ProductImgPath'],item['ProductDetail']));
    });
    setState(() {
      loadcatenoburn();
    });
  }

  loadcatenoburn() async {
    final res_noburn =
        await http.get(url.urlset + slug_category + '?cate_id=1');
    final body_noburn = json.decode(res_noburn.body);
    body_noburn.forEach((item) {
      productnoburn.add(Product(
          int.parse("${item['ProductID']}"),
          item['ProductName'],
          item['ProductNameEng'],
          double.parse("${item['Price']}"),
          double.parse("${item['Price_One']}"),
          item['ProductImgPath'],item['ProductDetail']));
    });
    setState(() {
      loadcateorganic();
      _saving = false;
    });
  }

  loadcateorganic() async {
    final res_organic =
        await http.get(url.urlset + slug_category + '?cate_id=7');
    final organic = json.decode(res_organic.body);
    organic.forEach((item) {
      productorganic.add(Product(
          int.parse("${item['ProductID']}"),
          item['ProductName'],
          item['ProductNameEng'],
          double.parse("${item['Price']}"),
          double.parse("${item['Price_One']}"),
          item['ProductImgPath'],item['ProductDetail']));
    });
    setState(() {
      loadcatecomunity();
      _saving = false;
    });
  }

  loadcatecomunity() async {
    final res_comunity =
        await http.get(url.urlset + slug_category + '?cate_id=6');
    final comunity = json.decode(res_comunity.body);
    comunity.forEach((item) {
      productcomunity.add(Product(
          int.parse("${item['ProductID']}"),
          item['ProductName'],
          item['ProductNameEng'],
          double.parse("${item['Price']}"),
          double.parse("${item['Price_One']}"),
          item['ProductImgPath'],item['ProductDetail']));
    });
    setState(() {
      _saving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          leading: IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              _handleDrawer();
            },
          ),
          title: Text('OUIKUM'),
          actions: [
            IconButton(icon: Icon(Icons.account_circle), onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
            })
          ],
        ),
        drawer: new Drawer(
            child: Container(
          // color: Colors.amber,
          child: ListView(
            children: <Widget>[
              // UserAccountsDrawerHeader(
              //   accountName: Text("Ashish Rawat"),
              //   accountEmail: Text("ashishrawat2911@gmail.com"),
              //   currentAccountPicture: CircleAvatar(
              //     backgroundColor:
              //         Theme.of(context).platform == TargetPlatform.iOS
              //             ? Colors.blue
              //             : Colors.white,
              //     child: Text(
              //       "A",
              //       style: TextStyle(fontSize: 40.0),
              //     ),
              //   ),
              // ),
              for (var o in catemenu)
                ListTile(
                  title: Text("${o.CategoryName}"),
                  trailing: Icon(Icons.arrow_forward),
                ),
            ],
          ),
        )),
        body: ModalProgressHUD(
            inAsyncCall: _saving,
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider.builder(
                        itemCount: b2bbanner.length,
                        itemBuilder: (_, index) {
                          return Container(
                            child: Center(
                              child: Image.network(b2bbanner[index].banner_url,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        )),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "สินค้าใหม่",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            IconButton(
                                icon: Icon(Icons.search), onPressed: () {})
                          ]),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 140,
                        child: new ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            for (var o in b2bproduct)
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetail(product : o)));
                                },
                                child: Container(
                                    margin: EdgeInsets.all(5),
                                    width: 180.0,
                                    child: Column(
                                      children: [
                                        Image.network(
                                          o.ProductImgPath,
                                          fit: BoxFit.cover,
                                          height: 90,
                                          width:
                                          MediaQuery.of(context).size.width,
                                        ),
                                        Text(
                                          '${o.ProductName}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "${o.Price} ฿",
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    )),
                              )

                          ],
                        )),
                    Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(height: 20.0),
                            Text('รายการสินค้า',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 22)),
                            DefaultTabController(
                                length: 3, // length of tabs
                                initialIndex: 0,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Container(
                                        child: TabBar(
                                          labelColor: Colors.amber,
                                          unselectedLabelColor: Colors.black,
                                          tabs: [
                                            Tab(text: 'สินค้าลดเผา'),
                                            Tab(text: 'เกษตรอินทรีย์'),
                                            Tab(text: 'ผลิตภัณฑ์(OTOP)'),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          height: 400, //height of TabBarView
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  top: BorderSide(
                                                      color: Colors.grey,
                                                      width: 0.5))),
                                          child: TabBarView(children: <Widget>[
                                            Container(
                                              child: Center(
                                                  child: GridView.count(
                                                primary: false,
                                                padding:
                                                    const EdgeInsets.all(20),
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10,
                                                crossAxisCount: 2,
                                                children: <Widget>[
                                                  for (var noburn in productnoburn)
                                                    GestureDetector(
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetail(product: noburn)));
                                                      },
                                                      child:  Container(
                                                          margin:
                                                          EdgeInsets.all(5),
                                                          width: 180.0,
                                                          child: Column(
                                                            children: [
                                                              Image.network(
                                                                noburn
                                                                    .ProductImgPath,
                                                                fit: BoxFit.cover,
                                                                height: 90,
                                                                width:
                                                                MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width,
                                                              ),
                                                              Text(
                                                                '${noburn.ProductName}',
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                              ),
                                                              Text(
                                                                "${noburn.Price} ฿",
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                              )
                                                            ],
                                                          )),
                                                    )
                                                   
                                                ],
                                              )),
                                            ),
                                            Container(
                                              child: Center(
                                                child: GridView.count(
                                                  primary: false,
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  crossAxisSpacing: 10,
                                                  mainAxisSpacing: 10,
                                                  crossAxisCount: 2,
                                                  children: <Widget>[
                                                    for (var organic
                                                        in productorganic)
                                                      GestureDetector(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetail(product: organic)));

                                                        },
                                                        child:  Container(
                                                            margin:
                                                            EdgeInsets.all(5),
                                                            width: 180.0,
                                                            child: Column(
                                                              children: [
                                                                Image.network(
                                                                  organic
                                                                      .ProductImgPath,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 90,
                                                                  width: MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .width,
                                                                ),
                                                                Text(
                                                                  '${organic.ProductName}',
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                ),
                                                                Text(
                                                                  "${organic.Price} ฿",
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                )
                                                              ],
                                                            )),
                                                      )

                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Center(
                                                  child: GridView.count(
                                                primary: false,
                                                padding:
                                                    const EdgeInsets.all(20),
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10,
                                                crossAxisCount: 2,
                                                children: <Widget>[
                                                  for (var community
                                                      in productcomunity)
                                                    GestureDetector(
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetail(product: community)));

                                                      },
                                                      child:  Container(
                                                          margin:
                                                          EdgeInsets.all(5),
                                                          width: 180.0,
                                                          child: Column(
                                                            children: [
                                                              Image.network(
                                                                community
                                                                    .ProductImgPath,
                                                                fit: BoxFit.cover,
                                                                height: 90,
                                                                width:
                                                                MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width,
                                                              ),
                                                              Text(
                                                                '${community.ProductName}',
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                              ),
                                                              Text(
                                                                "${community.Price} ฿",
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                              )
                                                            ],
                                                          )),
                                                    )

                                                ],
                                              )),
                                            ),
                                          ]))
                                    ])),
                          ]),
                    ),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "แนะนำ",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            IconButton(
                                icon: Icon(Icons.search), onPressed: () {})
                          ]),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 140,
                        child: new ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            for (var o in product_advertisement)
                              Container(
                                  margin: EdgeInsets.all(5),
                                  width: 180.0,
                                  child: Column(
                                    children: [
                                      Image.network(
                                        o.ProductImgPath,
                                        fit: BoxFit.cover,
                                        height: 90,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                      Text(
                                        '${o.ProductName}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "${o.Price} ฿",
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  )),
                          ],
                        )),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "ข่าวสาร",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            IconButton(
                                icon: Icon(Icons.search), onPressed: () {})
                          ]),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 140,
                        child: new ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            for (var o in listaffiliate)
                              Container(
                                  margin: EdgeInsets.all(5),
                                  width: 180.0,
                                  child: Column(
                                    children: [
                                      Image.network(
                                        o.affiliate_img1,
                                        fit: BoxFit.cover,
                                        height: 90,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                      Text(
                                        '${o.affiliate_name}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  )),
                          ],
                        )),
                  ],
                ),
              ),
            )
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.add_shopping_cart),
        backgroundColor: Colors.amber,
      ),

    );
  }
}
