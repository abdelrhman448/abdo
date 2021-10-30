import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:maosul/localization/localizationSetup/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../helper/app_styles.dart';
import '../provider/auth_provider.dart';
import '../provider/carts_provider.dart';
import '../screens/cart.dart';

class WorkTime extends StatefulWidget {
  @override
  _WorkTimeState createState() => _WorkTimeState();
}

class _WorkTimeState extends State<WorkTime> {
  @override
  Widget build(BuildContext context) {
    var localization=AppLocalization.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          localization.translate('Work hours'),
          style: AppStyles.txtAppBarStyle,
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
      ),
      body: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 3,
                padding: const EdgeInsets.only(top: 0, left: 12.0, right: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                  ),
                  color: AppStyles.lineColor(1),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: _personalInformation(context),
          ),
        ],
      ),
    );
  }

  ///Personal information
  Widget _personalInformation(BuildContext context) {
    return Consumer<AuthProvider>(builder: (ctx, auth, child) {
      return Container(
        child: Center(
          child: SingleChildScrollView(

            child: Column(
              children: [
                ///Personal information
                ListTile(
                  title: Text(
                    AppLocalization.of(context).translate('times of work'),
                    style: TextStyle(
                      color: Colors.white,

                    ),
                  ),
                ),
                Card(
                  elevation: 3.0,
                  child: ListTile(
                    title: Text(
                      AppLocalization.of(context).translate('Saturday'),
                      style: AppStyles.txtLabelStyle,
                    ),
                    subtitle: Text(
                      AppLocalization.of(context).translate('From 8 am to 5 pm'),
                      style: AppStyles.txtLabelStyle,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Card(
                  elevation: 3.0,
                  child: ListTile(
                    title: Text(
                      AppLocalization.of(context).translate('Sunday'),
                      style: AppStyles.txtLabelStyle,
                    ),
                    subtitle: Text(
                      AppLocalization.of(context).translate('From 8 am to 5 pm'),
                      style: AppStyles.txtLabelStyle,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Card(
                  elevation: 3.0,
                  child: ListTile(
                    title: Text(
                      AppLocalization.of(context).translate('Monday'),
                      style: AppStyles.txtLabelStyle,
                    ),
                    subtitle: Text(
                     AppLocalization.of(context).translate('From 8 am to 5 pm'),
                      style: AppStyles.txtLabelStyle,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Card(
                  elevation: 3.0,
                  child: ListTile(
                    title: Text(
                      AppLocalization.of(context).translate('Tuesday'),
                      style: AppStyles.txtLabelStyle,
                    ),
                    subtitle: Text(
                      AppLocalization.of(context).translate('From 8 am to 5 pm'),
                      style: AppStyles.txtLabelStyle,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Card(
                  elevation: 3.0,
                  child: ListTile(
                    title: Text(
                      AppLocalization.of(context).translate('Wednesday'),
                      style: AppStyles.txtLabelStyle,
                    ),
                    subtitle: Text(
                      AppLocalization.of(context).translate('From 8 am to 5 pm'),
                      style: AppStyles.txtLabelStyle,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Card(
                  elevation: 3.0,
                  child: ListTile(
                    title: Text(
                      AppLocalization.of(context).translate('Thursday'),
                      style: AppStyles.txtLabelStyle,
                    ),
                    subtitle: Text(
                      AppLocalization.of(context).translate('From 8 am to 5 pm'),
                      style: AppStyles.txtLabelStyle,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Card(
                  elevation: 3.0,
                  child: ListTile(
                    title: Text(
                      AppLocalization.of(context).translate('Friday'),
                      style: AppStyles.txtLabelStyle,
                    ),
                    subtitle: Text(
                      AppLocalization.of(context).translate('From 8 am to 5 pm'),
                      style: AppStyles.txtLabelStyle,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
