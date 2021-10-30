import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maosul/localization/localizationSetup/app_localization.dart';
import 'package:maosul/provider/socket_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../helper/app_styles.dart';
import '../provider/carts_provider.dart';
import '../screens/FadeAnimation.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Provider.of<SocketProvider>(context, listen: false).connect();
  }

  @override
  Widget build(BuildContext context) {
    var localization=AppLocalization.of(context);
    var provider = Provider.of<CartsProvider>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
         localization.translate('Cart'),
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
            child: Consumer<CartsProvider>(
              builder: (ctx, cart, child) {
                return ListView.builder(
                  itemCount: cart.cartProducts.length,
                  itemBuilder: (ctx, i) {
                    var cartModel = cart.cartProducts[i];

                    return FadeAnimation(
                      i == 0
                          ? 0.1
                          : i > 6
                              ? i / 5
                              : i / 3,
                      Card(
                        elevation: 3,
                        child: Stack(
                          children: [
                            _cartProduct(context, cartModel),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 24,
                                height: 24,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(right: 10, top: 20),
                                child: InkWell(
                                  onTap: () {
                                    provider.removeFromCart(
                                      scaffoldKey: _scaffoldKey,
                                      index: i,
                                    );
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomSheet: InkWell(
        onTap: () {},
        child: Container(
          height: Platform.isIOS ? 60 : 50,
          color: AppStyles.iconColor(1),
          alignment: Alignment.center,
          child: Consumer<CartsProvider>(
            builder: (ctx, cart, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    
                    '${localization.translate('Total')} : ${cart.total} ${localization.translate('L.E')}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    // "التوصيل : ${cart.getDeliveryFee} جنية",
                    '${localization.translate('Delivery') } : ${cart.getDeliveryFee} ${localization.translate('L.E')}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: Consumer<CartsProvider>(
        builder: (ctx, cart, child) {
          return FloatingActionButton(
            backgroundColor: AppStyles.mainColor(1),
            autofocus: true,
            elevation: 3,
            onPressed: () async {
              if (cart.cartProducts.isNotEmpty) {
                await cart
                    .prepareOrderForSocket(
                  scaffoldKey: _scaffoldKey,
                  product: cart.cartProducts,
                )
                    .then((orderModel) {
                  Provider.of<SocketProvider>(
                    context,
                    listen: false,
                  ).sendOrder(
                    scaffoldKey: _scaffoldKey,
                    order: orderModel,
                  );
                }).catchError((e) {
                  print(e);
                });
              } else {
                Alert(
                  context: context,
                  type: AlertType.warning,
                  style: AppStyles.alertStyle,
                  title: AppStyles.appArName,
                  desc: localization.translate('Sorry Please Add Product First To Complete Order Process'),
                  buttons: [
                    DialogButton(
                      child: Text(
                        localization.translate('Accept'),
                        style: AppStyles.txtBtnStyle,
                      ),
                      onPressed: () {

                        Navigator.of(context).pop();
                      },
                      color: AppStyles.lineColor(1),
                    )
                  ],
                ).show();
              }
            },
            child: Icon(
              Icons.send,
              size: 30,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget _cartProduct(context, cartModel) {
    var provider = Provider.of<CartsProvider>(context, listen: false);
    return Container(
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            child: Container(
              width: 120,
              height: 120,
              child: cartModel.imageUrl != null
                  ? Image.network(
                      "${cartModel.imageUrl[0]}",
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      "assets/images/placeholder.png",
                    ),
            ),
          ),
          SizedBox(width: 15),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 8),
                      Text(
                        cartModel.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'السعر : ${cartModel.price}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'الوحدة : لتر',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        provider.incrementQuantity(cartModel);
                      },
                      iconSize: 30,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      icon: Icon(
                        Icons.add_circle_outline,
                      ),
                      color: Theme.of(context).hintColor,
                    ),
                    Text(
                      cartModel.quantity.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    IconButton(
                      onPressed: () {
                        provider.decrementQuantity(cartModel);
                      },
                      iconSize: 30,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      icon: Icon(
                        Icons.remove_circle_outline,
                      ),
                      color: Theme.of(context).hintColor,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
