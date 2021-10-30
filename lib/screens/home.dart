import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:maosul/helper/route_argument.dart';
import 'package:maosul/localization/localizationSetup/app_localization.dart';
import 'package:maosul/navigation/route_paths.dart';
import 'package:maosul/provider/app_provider.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../helper/app_styles.dart';
import '../provider/auth_provider.dart';
import '../provider/carts_provider.dart';
import '../provider/notification_provider.dart';
import '../screens/FadeAnimation.dart';
import '../screens/cart.dart';
import '../screens/contactUs.dart';
import '../screens/login.dart';
import '../screens/pages/historyPage.dart';
import '../screens/pages/homePage.dart';
import '../screens/pages/notificationPage.dart';
import '../screens/profile.dart';
import '../screens/special_packages.dart';
import '../screens/workTime.dart';



class Home extends StatefulWidget {
  final String title;
  RouteArgument routeArgument;
  Home({this.title, this.routeArgument});


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var localization=AppLocalization.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(context),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Consumer<AuthProvider>(
              builder: (ctx, auth, child) {
                return UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: AppStyles.mainColor(1),
                  ),
                  accountName: Text(
                    auth.name != null ? auth.name : localization.translate('User Name'),
                    style: AppStyles.drawerHeaderTxtColor,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                  accountEmail: Row(
                    children: <Widget>[
                      Text(
                        auth.phone != null ? auth.phone : localization.translate('Mobile Number'),
                        style: AppStyles.drawerHeaderTxtColor,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  currentAccountPicture: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/drawer.png",
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            FadeAnimation(
              0.1,
              Card(
                elevation: 0.1,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  title: Text(
                    localization.translate('Main Page'),
                    style: AppStyles.drawerTxtColor,
                  ),
                  leading: Icon(
                    Icons.home,
                    color: AppStyles.mainColor(1),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: AppStyles.mainColor(1),
                  ),
                ),
              ),
            ),
            FadeAnimation(
              0.3,
              Consumer<AuthProvider>(builder: (ctx, auth, child) {
                return Card(
                  elevation: 0.1,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      auth.isAuth
                          ? Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.scale,
                                duration: Duration(
                                  seconds: 0,
                                  milliseconds: 700,
                                ),
                                alignment: Alignment.center,
                                child: Profile(),
                              ),
                            )
                          : Alert(
                              context: context,
                              type: AlertType.warning,
                              style: AppStyles.alertStyle,
                              title: AppStyles.appArName,
                              desc:localization.translate('Please login first to view profile'),
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    localization.translate('Cancel'),
                                    style: AppStyles.txtBtnStyle,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  color: AppStyles.lineColor(1),
                                ),
                                DialogButton(
                                  child: Text(
                                    localization.translate('Accept'),
                                    style: AppStyles.txtBtnStyle,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.scale,
                                        duration: Duration(
                                          seconds: 0,
                                          milliseconds: 700,
                                        ),
                                        alignment: Alignment.center,
                                        child: Login(),
                                      ),
                                    );
                                  },
                                  color: AppStyles.lineColor(1),
                                )
                              ],
                            ).show();
                    },
                    title: Text(
                      localization.translate('Profile'),
                      style: AppStyles.drawerTxtColor,
                    ),
                    leading: Icon(
                      Icons.person,
                      color: AppStyles.mainColor(1),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: AppStyles.mainColor(1),
                    ),
                  ),
                );
              }),
            ),
            FadeAnimation(
              0.5,
              Card(
                elevation: 0.1,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.scale,
                        duration: Duration(
                          seconds: 0,
                          milliseconds: 700,
                        ),
                        alignment: Alignment.center,
                        child: Cart(),
                      ),
                    );
                  },
                  title: Consumer<CartsProvider>(
                    builder: (ctx, cart, child) {
                      return Text(
                        "${localization.translate('Cart')} (${cart.productsList.length})",
                        style: AppStyles.drawerTxtColor,
                      );
                    },
                  ),
                  leading: Icon(
                    Icons.shopping_cart,
                    color: AppStyles.mainColor(1),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: AppStyles.mainColor(1),
                  ),
                ),
              ),
            ),
            FadeAnimation(
              0.7,
              Card(
                elevation: 0.1,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    final CurvedNavigationBarState navBarState =
                        _bottomNavigationKey.currentState;
                    navBarState.setPage(1);
                  },
                  title: Text(
                    localization.translate('My Orders'),
                    style: AppStyles.drawerTxtColor,
                  ),
                  leading: Icon(
                    Icons.shop_two,
                    color: AppStyles.mainColor(1),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: AppStyles.mainColor(1),
                  ),
                ),
              ),
            ),
            FadeAnimation(
              0.9,
              Card(
                elevation: 0.1,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.scale,
                        duration: Duration(
                          seconds: 0,
                          milliseconds: 700,
                        ),
                        alignment: Alignment.center,
                        child: WorkTime(),
                      ),
                    );
                  },
                  title: Text(
                    localization.translate('Work Time'),
                    style: AppStyles.drawerTxtColor,
                  ),
                  leading: Icon(
                    Icons.watch_later,
                    color: AppStyles.mainColor(1),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: AppStyles.mainColor(1),
                  ),
                ),
              ),
            ),
            FadeAnimation(
              1.1,
              Card(
                elevation: 0.1,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.scale,
                        duration: Duration(
                          seconds: 0,
                          milliseconds: 700,
                        ),
                        alignment: Alignment.center,
                        child: ContactUs(),
                      ),
                    );
                  },
                  title: Text(
                    localization.translate('Call Us'),
                    style: AppStyles.drawerTxtColor,
                  ),
                  leading: Icon(
                    Icons.call,
                    color: AppStyles.mainColor(1),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: AppStyles.mainColor(1),
                  ),
                ),
              ),
            ),
            FadeAnimation(
              1.3,
              Card(
                elevation: 0.1,
                child: Consumer<AuthProvider>(
                  builder: (ctx, auth, child) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        Alert(
                          context: context,
                          type: AlertType.warning,
                          style: AppStyles.alertStyle,
                          title: AppStyles.appArName,
                          desc: localization.translate('Do you want to logout'),
                          buttons: [
                            DialogButton(
                              child: Text(
                                localization.translate('Cancel'),
                                style: AppStyles.txtBtnStyle,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              color: AppStyles.lineColor(1),
                            ),
                            DialogButton(
                              child: Text(
                                localization.translate('Accept'),
                                style: AppStyles.txtBtnStyle,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                auth.logOut(scaffoldKey: _scaffoldKey);
                              },
                              color: AppStyles.lineColor(1),
                            )
                          ],
                        ).show();
                      },
                      title: Text(
                       localization.translate('Logout'),
                        style: AppStyles.drawerTxtColor,
                      ),
                      trailing: Icon(
                        Icons.exit_to_app,
                        color: AppStyles.mainColor(1),
                      ),
                    );
                  },
                ),
              ),
            ),
            FadeAnimation(
              1.5,
              Card(
                elevation: 0.1,
                child: Consumer<AppProvider>(
                  builder: (ctx, auth, child) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                       auth.changeLang();
                       print(isArabic);

                      },
                      title: Text(
                        localization.translate('Change'),
                        style: AppStyles.drawerTxtColor,
                      ),
                      trailing: Icon(
                        Icons.exit_to_app,
                        color: AppStyles.mainColor(1),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {

          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.scale,
              duration: Duration(seconds: 0, milliseconds: 700),
              alignment: Alignment.center,
              child: Specialackages(),
            ),
          );
        },
        label: Text(
          localization.translate('Parcels'),
          style: AppStyles.txtBtnStyle,
        ),
        backgroundColor: AppStyles.btnColor(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            style: BorderStyle.solid,
            color: AppStyles.btnColor(1),
            width: 0.3,
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppStyles.mainColor(1),
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            semanticLabel: localization.translate('Main Page'),
            color: AppStyles.btnColor(1),
          ),
          Icon(
            Icons.history,
            size: 30,
            semanticLabel:  localization.translate('My Orders'),
            color: AppStyles.btnColor(1),
          ),
          Stack(
            children: <Widget>[
              Icon(
                Icons.notifications_active,
                size: 30,
                semanticLabel:  localization.translate('Notifications'),
                color: AppStyles.btnColor(1),
              ),
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Consumer<NotificationProvider>(
                      builder: (ctx, count, child) {
                    return Text(
                      '${count.getCounters}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }

  // ignore: missing_return
  Widget _body(BuildContext context) {
    switch (_page) {
      case 0:
        return HomePage();
        break;
      case 1:
        return HistoryPage();
        break;
      case 2:
        return NotificationPage();
        break;
    }
  }

  // ignore: missing_return
  Widget _appBar(BuildContext context) {
    switch (_page) {
      case 0:
        return AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            AppLocalization.of(context).translate('Maosul'),
            style: AppStyles.txtAppBarStyle,
          ),
          leading: GestureDetector(
            onTap: () => _scaffoldKey.currentState.openDrawer(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/drawer.png",
                ),
              ),
            ),
          ),
          actions: <Widget>[
            Stack(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.scale,
                        duration: Duration(
                          seconds: 0,
                          milliseconds: 700,
                        ),
                        alignment: Alignment.center,
                        child: Cart(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: AppStyles.mainColor(1),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 5,
                  child: Consumer<CartsProvider>(
                    builder: (ctx, cart, child) {
                      return Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          '${cart.productsList.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        );
        break;
      case 1:
        return AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(AppLocalization.of(context).translate('My Orders'), style: AppStyles.txtAppBarStyle),
          leading: GestureDetector(
            onTap: () => _scaffoldKey.currentState.openDrawer(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/drawer.png",
                ),
              ),
            ),
          ),
          actions: <Widget>[
            Stack(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.scale,
                        duration: Duration(
                          seconds: 0,
                          milliseconds: 700,
                        ),
                        alignment: Alignment.center,
                        child: Cart(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: AppStyles.mainColor(1),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 5,
                  child: Consumer<CartsProvider>(
                    builder: (ctx, cart, child) {
                      return Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          '${cart.productsList.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        );
        break;
      case 2:
        return AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(AppLocalization.of(context).translate('Notifications'), style: AppStyles.txtAppBarStyle),
          leading: GestureDetector(
            onTap: () => _scaffoldKey.currentState.openDrawer(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/drawer.png",
                ),
              ),
            ),
          ),
          actions: <Widget>[
            Stack(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.scale,
                        duration: Duration(
                          seconds: 0,
                          milliseconds: 700,
                        ),
                        alignment: Alignment.center,
                        child: Cart(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: AppStyles.mainColor(1),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 5,
                  child: Consumer<CartsProvider>(
                    builder: (ctx, cart, child) {
                      return Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          '${cart.productsList.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        );
        break;
    }
  }
}
