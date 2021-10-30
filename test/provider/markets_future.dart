import 'package:maosul/helper/apiHandler.dart';
import 'package:maosul/helper/apiRoutes.dart';
import 'package:maosul/model/markets_model.dart';

class MarkersApi {
  ApiHandler apiHandler = new ApiHandler();

  Future<List<MarketsModel>> fetchMarkets() async {
    try {
      await apiHandler.getToken(url: ApiRoutes.markets).then((apiRes) {
        if (apiRes.code == 1) {
          final marketsModels = MarketsModel.fromMap(apiRes.object);
          return marketsModels;
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
