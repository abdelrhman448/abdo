import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maosul/helper/cashe_helper.dart';

import 'package:maosul/navigation/route_paths.dart';

import '../helper/app_styles.dart';

enum UserOnlineStatus { connecting, online, not_online }

class AppProvider extends ChangeNotifier {
  ThemeData theme = AppStyles().theme;
  Key key = UniqueKey();
  var navigatorKey = GlobalKey<NavigatorState>();




  ThemeData get getTheme => theme;


  void setKey(value) {
    key = value;
    notifyListeners();
  }

  void setNavigatorKey(value) {
    navigatorKey = value;
    notifyListeners();
  }

  void changeLang(){
    isArabic=!isArabic;
    CasheHelper.putData(key: 'isArabic', value: isArabic);
    notifyListeners();

  }


}
