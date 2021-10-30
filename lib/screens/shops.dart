import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:maosul/localization/localizationSetup/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../helper/app_styles.dart';
import '../provider/carts_provider.dart';
import '../provider/shops_provider.dart';
import '../screens/FadeAnimation.dart';
import '../screens/cart.dart';
import '../screens/shops_categories.dart';

class Shops extends StatefulWidget {
  int marketID;
  String marketName;
  String marketImage;
  Shops({
    this.marketID,
    this.marketName,
    this.marketImage,
  });
  @override
  _ShopsState createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {
  @override
  void initState() {
    Provider.of<ShopsProvider>(context, listen: false)
        .fetchMarketsShops(widget.marketID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.marketName,
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
            child: Consumer<ShopsProvider>(
              builder: (ctx, shop, child) {
                return shop.isLoading
                    ? SizedBox(
                        height: 3,
                        child: LinearProgressIndicator(
                          backgroundColor: AppStyles.lineColor(1),
                        ),
                      )
                    : shop.getMarketsShops.length > 0
                    ? ListView.builder(
                        itemCount: shop.getMarketsShops.length,
                        itemBuilder: (ctx, i) {
                          var shops = shop.getMarketsShops[i];
                          return  FadeAnimation(
                                  i == 0
                                      ? 0.1
                                      : i > 6
                                          ? i / 5
                                          : i / 3,
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.scale,
                                          duration: Duration(
                                            seconds: 0,
                                            milliseconds: 700,
                                          ),
                                          alignment: Alignment.center,
                                          child: ShopsCategories(
                                            shopID: shops.id,
                                            shopName: shops.name,
                                            shopImage: shops.imageUrl[0],
                                            shopLatitude: shops.latitude,
                                            shopLongitude: shops.longitude,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      elevation: 3.0,
                                      shadowColor: Colors.white,
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.black54,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1.0,
                                            style: BorderStyle.solid,
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              "${shops.imageUrl[0]}",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black54,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Container(
                                                  height: 80,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    image: new DecorationImage(
                                                      image: new NetworkImage(
                                                        shops.imageUrl[0],
                                                      ),
                                                      fit: BoxFit.fill,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  shops.name,
                                                  style: AppStyles.txtNameStyle,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ;
                        },
                      ) : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(AppLocalization.of(context).translate('No stores')),
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
          )
        ],
      ),
    );
  }
}
