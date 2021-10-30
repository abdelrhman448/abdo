import 'package:flutter/foundation.dart';

import '../helper/apiHandler.dart';
import '../helper/apiRoutes.dart';
import '../model/products_model.dart';

class ProductsProvider extends ChangeNotifier {
  ApiHandler apiHandler = new ApiHandler();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void updateStatus(bool status) {
    _isLoading = status;
  }

  ///Fetch all  Shops by markets ID
  List<DatumProduct> productsList = [];
  List<DatumProduct> get getProducts => productsList;
  Future<void> fetchProducts(int categoryID) async {
    updateStatus(true);
    try {
      await apiHandler
          .getToken(url: ApiRoutes.getProductsByCategoryID(categoryID))
          .then((apiRes) {
        updateStatus(false);
        if (apiRes.code == 1) {
          if (productsList.isEmpty) {
            final object = ProductsModel.fromMap(apiRes.object);
            productsList.addAll(object.products);
          }
          notifyListeners();
        } else {
          productsList = [];
          notifyListeners();
        }
      });
    } catch (e) {
      print("######################");
      print("######################");
      print(e);
      print("######################");
      print("######################");
      updateStatus(false);
      productsList = [];
      notifyListeners();
    }
  }
}
