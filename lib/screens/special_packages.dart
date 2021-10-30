import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:maosul/localization/localizationSetup/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';

import '../helper/app_styles.dart';
import '../provider/carts_provider.dart';
import '../screens/cart.dart';

class Specialackages extends StatefulWidget {
  @override
  _SpecialackagesState createState() => _SpecialackagesState();
}

class _SpecialackagesState extends State<Specialackages> {
  TextEditingController packNameCon = new TextEditingController();
  TextEditingController packDescCon = new TextEditingController();
  String latitude;
  String longitude;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String address = 'يرجى إختيار عنوان الوظيفة على الخريطة';

  @override
  Widget build(BuildContext context) {
    var localization=AppLocalization.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
         localization.translate('Special parcel delivery request'),
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
            padding: const EdgeInsets.only(top: 3.0, left: 5, right: 5),
            child: ListView(
              children: [
                SizedBox(
                  height: 10.0,
                ),

                ///Package Name
                Text(
                  localization.translate('Enter your name'),
                  style: AppStyles.txtTitleStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: packNameCon,
                  decoration: InputDecoration(
                    labelText:localization.translate('Enter the name of the request'),
                    hintText: localization.translate('Example: 10 kg cement'),
                    labelStyle: AppStyles.txtLabelStyle,
                    hintStyle: AppStyles.txtHintStyle,
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: Colors.teal,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.greenAccent,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),

                ///Package Description
                Text(
                   localization.translate('Description of the parcel request'),
                  style: AppStyles.txtTitleStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: packDescCon,
                  maxLines: 3,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: localization.translate('What do you need to deliver'),
                    labelStyle: AppStyles.txtLabelStyle,
                    hintText: localization.translate('Enter the description of the parcel'),
                    hintStyle: AppStyles.txtHintStyle,
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: Colors.teal,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.greenAccent,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),

                ///latitude longitude
                Text(
                  localization.translate('Select the parcel address for delivery'),
                  style: AppStyles.txtTitleStyle,
                ),
                /// islam location picker
                Card(
                  elevation: 3.0,
                  child: ListTile(
                    onTap: () async {
                    //   LocationResult result = await showLocationPicker(
                    //     context,
                    //     'AIzaSyBomj_bdMskpS1rPhnq2FC8F8hKjE4ayJA',
                    //     automaticallyAnimateToCurrentLocation: true,
                    //     initialZoom:22 ,
                    //     requiredGPS: true,
                    //
                    //     myLocationButtonEnabled: false,
                    //     resultCardAlignment: Alignment.bottomCenter,
                    //     resultCardDecoration: BoxDecoration(
                    //       color: AppStyles.secondColor(1),
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(5),
                    //       ),
                    //     ),
                    //     hintText: "إبحث عن العنوان",
                    //     searchBarBoxDecoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(5),
                    //       ),
                    //     ),
                    //   );
                    //
                    //
                    //   latitude = result.latLng.latitude.toString();
                    //   longitude = result.latLng.longitude.toString();
                    //   print("result = $result");
                    //   setState(() {
                    //     address = result.address;
                    //   });
                    },
                    title: Text(
                      localization.translate('Choose the address from the map'),
                      style: AppStyles.txtLabelStyle,
                    ),
                    subtitle: Text(
                      "$address",
                      style: AppStyles.txtHintStyle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Consumer<CartsProvider>(
        builder: (ctx, cart, child) {
          return FloatingActionButton(
            backgroundColor: AppStyles.mainColor(1),
            autofocus: true,
            elevation: 3,
            onPressed: () async {
              if (packNameCon.text.isEmpty) {
                SweetAlert.show(
                  context,
                  subtitle: localization.translate('Please enter the package name'),
                  confirmButtonText: localization.translate('Accept'),
                  style: SweetAlertStyle.error,
                  confirmButtonColor: AppStyles.btnColor(1),
                );
              } else if (packDescCon.text.isEmpty) {
                SweetAlert.show(
                  context,
                  subtitle: localization.translate('Please enter the description of the package'),
                  confirmButtonText: localization.translate('Accept'),
                  style: SweetAlertStyle.error,
                  confirmButtonColor: AppStyles.btnColor(1),
                );
              } else if (latitude == null) {
                SweetAlert.show(
                  context,
                  subtitle: localization.translate('Please select the location of the parcel'),
                  confirmButtonText:localization.translate('Accept'),
                  style: SweetAlertStyle.error,
                  confirmButtonColor: AppStyles.btnColor(1),
                );
              } else if (longitude == null) {
                SweetAlert.show(
                  context,
                  subtitle:localization.translate('Please select the location of the parcel'),
                  confirmButtonText:localization.translate('Accept'),
                  style: SweetAlertStyle.error,
                  confirmButtonColor: AppStyles.btnColor(1),
                );
              } else {
                AppStyles.showSweetAlert(
                  context,
                  subtitle: localization.translate('Looking for a delivery person...'),
                  style: SweetAlertStyle.loading,
                );
              }
            },
            child: Icon(
              Icons.send,
              size: 25,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
