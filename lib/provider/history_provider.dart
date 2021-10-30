import 'package:flutter/foundation.dart';

import '../model/history_model.dart';

class HistoryProvider extends ChangeNotifier {
  List<HistoryModel> history = [
    HistoryModel(
      code: 1,
      name: "المندوب : محمد على أحمد على",
      time: "الاحد 28 يونيو 6:30 م",
      status: "تم توصيل الطلب بنجاح",
      title: "قارورة ماء صافيه من بقاله",
    ),
    HistoryModel(
      code: 2,
      name: "المندوب : محمد على أحمد على",
      time: "الاحد 28 يونيو 6:30 م",
      status: "تم إالغاء الطلب",
      title: "8 كيلو عجالي ضان",
    ),
    HistoryModel(
      code: 3,
      name: "المندوب : محمد على أحمد على",
      time: "الاحد 28 يونيو 6:30 م",
      status: "الطلب قيد التوصيل",
      title: "معدات بناء وطرود",
    ),
  ];
}
