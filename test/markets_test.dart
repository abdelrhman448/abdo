import 'package:flutter_test/flutter_test.dart';

import 'provider/markets_future.dart';

void main() {
  test("markets test", () async {
    MarkersApi api = MarkersApi();
    var markets = await api.fetchMarkets();
  });
}
