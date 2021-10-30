import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:maosul/localization/localizationSetup/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phone_number/phone_number.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';

import '../helper/app_styles.dart';
import '../provider/auth_provider.dart';
import '../provider/parse_result.dart';
import '../provider/store.dart';
import '../screens/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final phoneController = new TextEditingController();
  final passwordController = new TextEditingController();
  final regionCtrl = TextEditingController();
  final numberCtrl = TextEditingController();
  final store = Store(PhoneNumber());
  String dialCode;
  String regionCode;
  Future<ParseResult> parse() async {
    return await store.parse(phoneController.text, region: regionCode);
  }

  @override
  Widget build(BuildContext context) {
    var localization=AppLocalization.of(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15, top: 100),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Container(
                    child: Image.asset(
                      "assets/images/undraw_Login_re_4vu2.png",
                    ),
                  ),
                ),

                ///mobile number
                TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: localization.translate('Mobile Number'),
                    labelStyle: AppStyles.txtLabelStyle,
                    hintStyle: AppStyles.txtHintStyle,
                    prefixIcon: const Icon(
                      Icons.phone_iphone,
                      color: Colors.grey,
                    ),
                    suffixIcon: CountryCodePicker(
                      onChanged: (code) {
                        setState(() {
                          dialCode = code.dialCode;
                          regionCode = code.code;
                        });
                      },
                      onInit: (code) {
                        dialCode = code.dialCode;
                        regionCode = code.code;
                      },
                      initialSelection: 'SD',
                      favorite: ['+249', 'SD'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                      textOverflow: TextOverflow.clip,
                      flagWidth: 30,
                      showFlagDialog: true,
                      showFlag: false,
                      textStyle: TextStyle(
                        fontSize: 12.0,
                        locale: Locale('en.json'),
                      ),
                      dialogTextStyle: TextStyle(
                        fontSize: 12.0,
                        locale: Locale('en.json'),
                      ),
                      searchStyle: TextStyle(
                        fontSize: 12.0,
                        locale: Locale('en.json'),
                      ),
                    ),
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
                SizedBox(height: 10),

                ///password
                TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: localization.translate('Password'),
                    labelStyle: AppStyles.txtLabelStyle,
                    hintStyle: AppStyles.txtHintStyle,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
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
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100,
                  child: FlatButton(
                    textColor: AppStyles.lineColor(1),
                    color: Colors.transparent,
                    child: Text(
                      localization.translate('Login'),
                      style: TextStyle(

                      ),
                    ),
                    onPressed: () async {
                      if (phoneController.text.isEmpty) {
                        SweetAlert.show(
                          context,
                          subtitle: localization.translate("Please enter mobile number"),
                          confirmButtonText:localization.translate('Accept'),
                          style: SweetAlertStyle.error,
                          confirmButtonColor: AppStyles.lineColor(1),
                        );
                      } else if (phoneController.text.length < 10) {
                        SweetAlert.show(
                          context,
                          subtitle: localization.translate('The phone number must not be less than 10 characters'),
                          confirmButtonText:localization.translate('Accept'),
                          style: SweetAlertStyle.error,
                          confirmButtonColor: AppStyles.lineColor(1),
                        );
                      } else if (phoneController.text.length > 10) {
                        SweetAlert.show(
                          context,
                          subtitle: localization.translate('The phone number must not be less than 10 characters'),
                          confirmButtonText: localization.translate('Accept'),
                          style: SweetAlertStyle.error,
                          confirmButtonColor: AppStyles.lineColor(1),
                        );
                      } else if (passwordController.text.length < 6) {
                        SweetAlert.show(
                          context,
                          subtitle: localization.translate('The password is too short'),
                          confirmButtonText: localization.translate('Accept'),
                          style: SweetAlertStyle.error,
                          confirmButtonColor: AppStyles.lineColor(1),
                        );
                      } else {
                        parse().then((phone) {
                          Provider.of<AuthProvider>(context, listen: false)
                              .login(
                            scaffoldKey: _scaffoldKey,
                            phone: phone.e164,
                            password: passwordController.text,
                          );
                        });
                      }
                    },
                  ),
                ),
                Container(
                  width: 100,
                  child: FlatButton(
                    textColor: AppStyles.lineColor(1),
                    color: Colors.transparent,
                    child: Text(
                      localization.translate('Sign Up'),
                      style: TextStyle(

                      ),
                    ),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.scale,
                          duration: Duration(
                            seconds: 0,
                            milliseconds: 700,
                          ),
                          alignment: Alignment.center,
                          child: Register(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
