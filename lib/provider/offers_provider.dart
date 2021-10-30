import 'package:flutter/foundation.dart';

import '../helper/apiHandler.dart';
import '../helper/apiRoutes.dart';
import '../model/offers_model.dart';

class OffersProvider extends ChangeNotifier {
  OffersProvider() {
    fetchOffers();
  }
  ApiHandler apiHandler = new ApiHandler();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void updateStatus(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  ///Fetch all  Offers
  List<DatumOffers> offersList = [];
  List<DatumOffers> get getOffers => offersList;
  Future<void> fetchOffers() async {
    offersList.clear();
    updateStatus(true);
    try {
      await apiHandler.getToken(url: ApiRoutes.offers).then((apiRes) {
        updateStatus(false);
        if (apiRes.code == 1) {
          if (offersList.isEmpty) {
            final offersModel = OffersModel.fromMap(apiRes.object);
            offersList.addAll(offersModel.offers);
          }
          notifyListeners();
        } else {
          offersList = [];
          notifyListeners();
        }
      });
    } catch (e) {
      updateStatus(false);
      offersList = [];
      notifyListeners();
    }
  }
}
