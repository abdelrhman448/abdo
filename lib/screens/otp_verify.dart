import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:maosul/helper/route_argument.dart';
import 'package:maosul/localization/localizationSetup/app_localization.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';

class OtpVerify extends StatefulWidget {
  String phone;
  String message;
  RouteArgument routeArgument;
  OtpVerify({this.phone, this.message, this.routeArgument});

  @override
  OtpVerifyState createState() => OtpVerifyState();
}

class OtpVerifyState extends State<OtpVerify> {
  bool seconds = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String sendOtp;

  @override
  Widget build(BuildContext context) {
    var localization=AppLocalization.of(context);
    var provider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Container(
                width: 200,
                height: 200,
                child: Image.asset(
                  "assets/images/undraw_forgot_password_gi2d.png",
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  " ${widget.phone} ${widget.message}",
                  style: TextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            PinCodeTextField(
              maxLength: 4,
              keyboardType: TextInputType.phone,
              autofocus: true,
              hideCharacter: false,
              highlight: false,
              highlightAnimation: true,
              highlightColor: Colors.transparent,
              hasError: false,
              pinBoxRadius: 10.0,
              pinTextAnimatedSwitcherDuration: Duration(microseconds: 300),
              pinBoxDecoration:
                  ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
              pinTextStyle: TextStyle(
                fontSize: 15.0,
                color: Colors.blueAccent,
              ),
              pinBoxOuterPadding: EdgeInsets.all(5.0),
              onDone: (otp) async {
                provider.verifyOtp(
                  scaffoldKey: _scaffoldKey,
                  phone: widget.phone,
                  otp: otp,
                );
                setState(() => sendOtp = otp);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 15.0,
                right: 15.0,
              ),
              child: ArgonTimerButton(
                initialTimer: 60,
                // Optional
                height: 30.0,
                width: MediaQuery.of(context).size.width * 0.50,
                minWidth: MediaQuery.of(context).size.width * 0.60,
                color: Colors.blueAccent,
                borderRadius: 2.0,
                elevation: 3.0,
                roundLoadingShape: true,
                child: Text(
                  localization.translate('Resend'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                loader: (timeLeft) {
                  return Text(
                    "${localization.translate('Resend after')}  $timeLeft ${localization.translate('second')}  ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                },
                onTap: (startTimer, btnState) async {
                  provider.sendOtp(
                    scaffoldKey: _scaffoldKey,
                    otp: sendOtp,
                  );
                  if (btnState == ButtonState.Idle) {
                    startTimer(60);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
