import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maosul/navigation/locator.dart';
import 'package:maosul/navigation/route_paths.dart';
import 'package:maosul/screens/app.dart';

import 'helper/cashe_helper.dart';





Future<void> main() async {
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CasheHelper.init();
  print(isArabic);
  if(CasheHelper.getData(key:'arabic')==null){
    isArabic=true;
  }
  else
    isArabic=CasheHelper.getData(key:'arabic');
  runApp(App());

}
