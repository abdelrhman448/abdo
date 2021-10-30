import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sweetalert/sweetalert.dart';

import '../helper/app_styles.dart';
import '../helper/sharedPref.dart';
import '../model/orders_model.dart';
import '../model/product_order_model.dart';
import '../model/products_model.dart';
import '../provider/app_provider.dart';

class CartsProvider extends ChangeNotifier {
  AppProvider appProvider;

  Function sendOrder;

  CartsProvider({this.appProvider, this.sendOrder});

  final SharedPref shared = new SharedPref();
  final List<DatumProduct> productsList = [];
  double total = 0.0;
  double subTotal = 0.0;
  double _deliveryFee = 0.0;
  double _distance = 0.0;
  int shopID;
  String shopName;
  String shopImage;
  String shopLatitude;
  String shopLongitude;
  double _latitude;
  double _longitude;

  double get getDeliveryFee => _deliveryFee;

  double get getDistance => _distance;

  double get getLatitude => _latitude;

  double get getLongitude => _longitude;

  int get getShopID => shopID;

  String get getShopName => shopName;

  String get getShopImage => shopImage;

  String get getShopLatitude => shopLatitude;

  String get getShopLongitude => shopLongitude;

  double get totals => total;

  List<DatumProduct> get cartProducts => productsList;

  setShopInfo(
      {int shopID,
      String shopName,
      String shopImage,
      String shopLatitude,
      String shopLongitude}) {
    this.shopID = shopID;
    this.shopName = shopName;
    this.shopImage = shopImage;
    this.shopLatitude = shopLatitude;
    this.shopLongitude = shopLongitude;
    notifyListeners();
  }

  addToCart(
      {GlobalKey<ScaffoldState> scaffoldKey, DatumProduct product}) async {
    if (!productsList.contains(product)) {
      productsList.add(product);
      await calculateSubtotal();
      await calculateDeliveryFee();
      AppStyles.showSweetAlert(
        scaffoldKey.currentState.context,
        subtitle: "تم إضافة العنصر الى سلة الطلبات",
        confirmButtonText: "موافق",
        style: SweetAlertStyle.success,
      );
    } else {
      AppStyles.showSweetAlert(
        scaffoldKey.currentState.context,
        subtitle: "عفواً هذا العنصر موجود في سلة الطلبات",
        confirmButtonText: "موافق",
        style: SweetAlertStyle.error,
      );
    }
    notifyListeners();
  }

  removeFromCart({GlobalKey<ScaffoldState> scaffoldKey, int index}) async {
    productsList[index].quantity = 1;
    productsList.removeAt(index);
    AppStyles.showSweetAlert(
      scaffoldKey.currentState.context,
      subtitle: "تم حذف العنصر من سلة الطلباتً",
      confirmButtonText: "موافق",
      style: SweetAlertStyle.success,
    );
    calculateSubtotal();
    notifyListeners();
  }

  incrementQuantity(DatumProduct product) async {
    if (product.quantity <= 99) {
      ++product.quantity;
      calculateSubtotal();
      calculateDeliveryFee();
    }
    notifyListeners();
  }

  decrementQuantity(DatumProduct product) async {
    if (product.quantity > 1) {
      --product.quantity;
      calculateSubtotal();
      calculateDeliveryFee();
    }
    notifyListeners();
  }

  calculateSubtotal() async {
    subTotal = 0.0;
    productsList.forEach((cart) {
      print(cart.quantity);
      print(cart.price);
      subTotal += cart.quantity * double.parse(cart.price);
    });
    total = subTotal;
  }

  calculateDeliveryFee() async {
    Position position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,);

    _latitude = position.latitude;
    _longitude = position.longitude;
    _distance = await Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      double.parse(getShopLatitude),
      double.parse(getShopLongitude),
    );
    _deliveryFee = _distance * 10;
  }

  Future<OrderModel> prepareOrderForSocket(
      {GlobalKey<ScaffoldState> scaffoldKey,
      List<DatumProduct> product}) async {
    try {
      ProductOrder _productOrder = new ProductOrder();
      _productOrder.products = new List<Product>();
      product.forEach((e) {
        _productOrder.products.add(Product(
          id: e.id,
          name: e.name,
          imageUrl: e.imageUrl[0],
          price: e.price,
          quantity: e.quantity,
        ));
      });
      final extData = await shared.read('userData');
      return OrderModel(
        total: totals,
        deliveryFee: getDeliveryFee,
        orderDistance: getDistance,
        fromShop: FromShop(
          id: getShopID,
          name: getShopName,
          shopLatitude: getShopLatitude,
          shopLongitude: getShopLongitude,
          imageUrl: getShopImage,
          area: 'area_one',
        ),
        toUser: ToUser(
          id: extData['id'],
          name: extData['name'],
          phone: extData['phone'],
          latitude: getLatitude,
          longitude: getLongitude,
        ),
        products: _productOrder.products
            .map(
              (e) => ProductCartOrder(
                id: e.id,
                name: e.name,
                price: e.price,
                quantity: e.quantity,
                imageUrl: e.imageUrl,
              ),
            )
            .toList(),
      );
    } catch (e) {
      AppStyles.showSweetAlert(
        scaffoldKey.currentState.context,
        subtitle: "عفواً هنالك خطأ",
        confirmButtonText: "موافق",
        style: SweetAlertStyle.error,
      );
    }
  }
}
