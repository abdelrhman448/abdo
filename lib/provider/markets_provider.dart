import 'package:flutter/foundation.dart';
import '../helper/apiHandler.dart';
import '../helper/apiRoutes.dart';
import '../model/markets_model.dart';

class MarketsProvider extends ChangeNotifier {
  MarketsProvider() {
    fetchMarkets();
  }

  ApiHandler apiHandler = new ApiHandler();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void updateStatus(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  ///Fetch all  Markets
  List<DatumMarket> marketsList = [];

  List<DatumMarket> get getMarkets => marketsList;

  Future<void> fetchMarkets() async {
    marketsList.clear();
    updateStatus(true);

    try {
      await apiHandler.getToken(url: ApiRoutes.markets).then((apiRes) {
        updateStatus(false);
        if (apiRes.code == 1) {
          if (marketsList.isEmpty) {
            final marketsModels = MarketsModel.fromMap(apiRes.object);
            marketsList.addAll(marketsModels.markets);
          }
          notifyListeners();
        } else {
          marketsList = [];
          notifyListeners();
        }
      });
    } catch (e) {
      updateStatus(false);
      marketsList = [];
      notifyListeners();
    }
  }
}
