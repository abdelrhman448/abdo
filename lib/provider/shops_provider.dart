import 'package:flutter/foundation.dart';

import '../helper/apiHandler.dart';
import '../helper/apiRoutes.dart';
import '../model/markets_shops_model.dart';

class ShopsProvider extends ChangeNotifier {
  ApiHandler apiHandler = new ApiHandler();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void updateStatus(bool status) {
    _isLoading = status;
  }

  ///Fetch all  Shops by markets ID
  List<DatumShops> marketsShopsList = [];
  List<DatumShops> get getMarketsShops => marketsShopsList;
  Future<void> fetchMarketsShops(int marketsID) async {
    updateStatus(true);
    marketsShopsList.clear();
    try {
      await apiHandler
          .getToken(url: ApiRoutes.getShopsByMarketsID(marketsID))
          .then((apiRes) {
        updateStatus(false);

        if (apiRes.code == 1) {
          if (marketsShopsList.isEmpty) {
            final shopsModels = MarketsShopsModel.fromMap(apiRes.object);

            marketsShopsList.addAll(shopsModels.shops);
          }
          notifyListeners();
        } else {
          marketsShopsList = [];
          notifyListeners();
        }
      });
    } catch (e) {
      updateStatus(false);
      marketsShopsList = [];
      notifyListeners();
    }
  }
}
