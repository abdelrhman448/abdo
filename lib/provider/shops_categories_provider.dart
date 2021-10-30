import 'package:flutter/foundation.dart';

import '../helper/apiHandler.dart';
import '../helper/apiRoutes.dart';
import '../model/categories_model.dart';

class ShopsCategoriesProvider extends ChangeNotifier {
  ApiHandler apiHandler = new ApiHandler();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void updateStatus(bool status) {
    _isLoading = status;
  }

  ///Fetch all  Shops by markets ID
  List<DatumCategory> marketsShopsCategoryList = [];
  List<DatumCategory> get getMarketsShops => marketsShopsCategoryList;
  Future<void> fetchShopsCategory(int shopID) async {
    marketsShopsCategoryList.clear();
    updateStatus(true);
    try {
      await apiHandler
          .getToken(url: ApiRoutes.getShopsCategoriesByID(shopID))
          .then((apiRes) {
        updateStatus(false);
        if (apiRes.code == 1) {
          if (marketsShopsCategoryList.isEmpty) {
            final shopsModels = CategoriesModel.fromMap(apiRes.object);
            marketsShopsCategoryList.addAll(shopsModels.categories);
          }
          notifyListeners();
        } else {
          marketsShopsCategoryList = [];
          notifyListeners();
        }
      });
    } catch (e) {
      updateStatus(false);
      marketsShopsCategoryList = [];
      notifyListeners();
    }
  }
}
