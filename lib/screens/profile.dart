import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:intl/intl.dart';
import 'package:maosul/localization/localizationSetup/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../helper/app_styles.dart';
import '../provider/auth_provider.dart';
import '../provider/carts_provider.dart';
import '../screens/cart.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    var localization=AppLocalization.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          localization.translate("Profile"),
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
                  color:  AppStyles.mainColor(1),
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
            child: ListView(
              children: [_personalInformation(context)],
            ),
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
          child: Column(
            children: [
              ///Personal information
              ListTile(
                title: Text(
                  AppLocalization.of(context).translate('Personal information'),
                  style: TextStyle(
                    color: Colors.white,

                  ),
                ),
                trailing: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   PageTransition(
                    //     type: PageTransitionType.scale,
                    //     duration: Duration(seconds: 0, milliseconds: 700),
                    //     alignment: Alignment.center,
                    //     child: EditProfile(
                    //       title: "المعلومات الشخصية",
                    //       formType: 'personal_information',
                    //       isEditing: true,
                    //       fName: detailsList.fName,
                    //       restName: detailsList.restName,
                    //       phone: detailsList.phone,
                    //       email: detailsList.email,
                    //     ),
                    //   ),
                    // );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, top: 2.0, bottom: 2.0),
                    child: Text(
                      AppLocalization.of(context).translate('Edit'),
                      style: TextStyle(
                        color: Colors.white,

                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 3.0,
                child: ListTile(
                  title: Text(
                    AppLocalization.of(context).translate('Name'),
                    style: AppStyles.txtLabelStyle,
                  ),
                  subtitle: Text(
                    "${auth.name}",
                    style: AppStyles.txtLabelStyle,
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              Card(
                elevation: 3.0,
                child: ListTile(
                  title: Text(
                    AppLocalization.of(context).translate('Email Address'),
                    style: AppStyles.txtLabelStyle,
                  ),
                  subtitle: Text(
                    "${auth.email}",
                    style: AppStyles.txtLabelStyle,
                  ),
                ),
              ),
              Card(
                elevation: 3.0,
                child: ListTile(
                  title: Text(
                    AppLocalization.of(context).translate('Mobile Number'),
                    style: AppStyles.txtLabelStyle,
                  ),
                  subtitle: Text(
                    "${auth.phone}",
                    style: AppStyles.txtLabelStyle,
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
