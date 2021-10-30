import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maosul/localization/localizationSetup/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../helper/app_styles.dart';
import '../provider/carts_provider.dart';
import '../provider/products_provider.dart';
import '../screens/FadeAnimation.dart';
import '../screens/cart.dart';

class Products extends StatefulWidget {
  int categoryID;
  String title;
  int shopID;
  String shopName;
  String shopImage;
  String shopLatitude;
  String shopLongitude;

  Products(
      {this.categoryID,
      this.title,
      this.shopID,
      this.shopName,
      this.shopImage,
      this.shopLatitude,
      this.shopLongitude});

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Provider.of<ProductsProvider>(context, listen: false)
        .fetchProducts(widget.categoryID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var localization=AppLocalization.of(context);
    var provider = Provider.of<CartsProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 30) / 3;
    final double itemWidth = size.width / 2;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "${widget.title}",
          style: AppStyles.txtAppBarStyle,
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.scale,
                      duration: Duration(
                        seconds: 0,
                        milliseconds: 700,
                      ),
                      alignment: Alignment.center,
                      child: Cart(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: AppStyles.mainColor(1),
                ),
              ),
              Positioned(
                right: 0,
                top: 5,
                child: Consumer<CartsProvider>(
                  builder: (ctx, cart, child) {
                    return Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '${cart.productsList.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 3,
                padding: const EdgeInsets.only(top: 0, left: 12.0, right: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                  ),
                  color: AppStyles.lineColor(1),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Consumer<ProductsProvider>(
              builder: (ctx, product, child) {
                return product.isLoading
                    ? SizedBox(
                        height: 3,
                        child: LinearProgressIndicator(
                          backgroundColor: AppStyles.lineColor(1),
                        ),
                      )
                    : product.getProducts.length > 0
                        ? GridView.builder(
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0,
                              childAspectRatio: (itemWidth / itemHeight),
                            ),
                            itemCount: product.getProducts.length,
                            itemBuilder: (ctx, i) {
                              return FadeAnimation(
                                i == 0
                                    ? 0.1
                                    : i > 6
                                        ? i / 5
                                        : i / 3,
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Container(
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.black54,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.0,
                                        // style: BorderStyle.solid,
                                      ),
                                      image: new DecorationImage(
                                        image: new NetworkImage(
                                          "${product.getProducts[i].imageUrl[0]}",
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.black54,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 80,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 1.0,
                                              ),
                                              image: new DecorationImage(
                                                image: new NetworkImage(
                                                  product.getProducts[i]
                                                      .imageUrl[0],
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            product.getProducts[i].name,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "${localization.translate('Unit')} : ${product.getProducts[i].discountPrice}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "(${product.getProducts[i].price}) : ${localization.translate('L.E')} ",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          FlatButton.icon(
                                            color: AppStyles.lineColor(1),
                                            splashColor: AppStyles.mainColor(1),
                                            textColor: Colors.white,
                                            onPressed: () {
                                              provider.addToCart(
                                                scaffoldKey: _scaffoldKey,
                                                product: product.getProducts[i],
                                              );
                                            },
                                            icon: Icon(Icons.add_shopping_cart),
                                            label: Text(
                                            localization.translate('Add to cart'),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      10.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(localization.translate('No products')),
                                Text(
                                  "..................",
                                  style: TextStyle(
                                    color: Colors.cyan,
                                  ),
                                ),
                              ],
                            ),
                          );
              },
            ),
          ),
        ],
      ),
    );
  }
}
