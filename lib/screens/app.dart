import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:maosul/helper/app_styles.dart';
import 'package:maosul/localization/localizationSetup/app_localization.dart';
import 'package:maosul/navigation/locator.dart';
import 'package:maosul/navigation/navigation_service.dart';
import 'package:maosul/navigation/route_paths.dart' as routes;
import 'package:maosul/navigation/route_paths.dart';
import 'package:maosul/navigation/router.dart' as router;

import 'package:maosul/provider/socket_provider.dart';
import 'package:provider/provider.dart';

import '../provider/app_provider.dart';
import '../provider/auth_provider.dart';
import '../provider/carts_provider.dart';
import '../provider/history_provider.dart';
import '../provider/markets_provider.dart';
import '../provider/notification_provider.dart';
import '../provider/offers_provider.dart';
import '../provider/orders_provider.dart';
import '../provider/products_provider.dart';
import '../provider/shops_categories_provider.dart';
import '../provider/shops_provider.dart';
import 'package:google_map_location_picker/generated/l10n.dart' as location_picker;
import 'package:flutter_localizations/flutter_localizations.dart';


class App extends StatelessWidget {
  var navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: MarketsProvider()),
        ChangeNotifierProvider.value(value: ProductsProvider()),
        ChangeNotifierProvider.value(value: OffersProvider()),
        ChangeNotifierProvider.value(value: ShopsProvider()),
        ChangeNotifierProvider.value(value: OrdersProvider()),
        ChangeNotifierProvider.value(value: HistoryProvider()),
        ChangeNotifierProvider.value(value: NotificationProvider()),
        ChangeNotifierProvider.value(value: ShopsCategoriesProvider()),
        ChangeNotifierProvider.value(value: CartsProvider()),
        ChangeNotifierProvider.value(value: SocketProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: (ctx, model, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // key: model.key,
            // navigatorKey: model.navigatorKey,
            title: AppStyles.appArName,
            theme: model.theme,
            localizationsDelegates: [
              AppLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              location_picker.S.delegate
            ],
            supportedLocales: [
              Locale('en', 'US'),
              Locale('ar', 'EG'),
            ],
            locale:isArabic==true?Locale('ar', 'EG'): Locale('en', 'US'),


            // home: Splash(),
            // initialRoute: "/Splash",
            // onGenerateRoute: RouteGenerator.generateRoute,
            navigatorKey: locator<NavigationService>().navigatorKey,
            onGenerateRoute: router.generateRoute,
            initialRoute: routes.SplashRoute,
          );
        },
      ),
    );
  }
}
