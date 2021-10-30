import 'dart:async';
import 'dart:io';
import 'package:maosul/helper/route_argument.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sweetalert/sweetalert.dart';

import '../helper/apiHandler.dart';
import '../helper/apiRoutes.dart';
import '../helper/app_styles.dart';
import '../helper/sharedPref.dart';
import '../screens/home.dart';
import '../screens/login.dart';
import '../screens/otp_verify.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    tryAutoLogin();
    fcmListeners();
  }

  final SharedPref shared = new SharedPref();
  final ApiHandler apiHandler = new ApiHandler();
  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  String _id;
  String _name;
  String _phone;
  String _email;
  String _updatedAt;
  String _createdAt;
  String _token;
  String _otp;
  String _deviceToken;

  String get id => _id;

  String get name => _name;

  String get phone => _phone;

  String get email => _email;

  bool get isAuth => _token != null;

  String get getDeviceToken => _deviceToken;

  ///Try Auto Login
  Future<bool> tryAutoLogin() async {
    final _ifExisting = await shared.ifExisting('userData');
    if (_ifExisting) {
      final extData = await shared.read('userData');
      print("############\t\n$extData\n\t##############");
      _id = extData['id'];
      _name = extData['name'];
      _phone = extData['phone'];
      _email = extData['email'];
      _updatedAt = extData['updated_at'];
      _createdAt = extData['created_at'];
      _token = extData['token'];
      _otp = extData['otp'];
    }
    notifyListeners();
    return true;
  }

  ///Register Methods
  void register({
    GlobalKey<ScaffoldState> scaffoldKey,
    String name,
    String phone,
    String email,
    String password,
    String cPassword,
    String gender,
    String birthDate,
  }) async {


    AppStyles.showSweetAlert(
      scaffoldKey.currentState.context,
      subtitle: "يرجى الإنتظار لحظة ...",
      style: SweetAlertStyle.loading,
    );
    try {
      apiHandler.post(
          url: ApiRoutes.register,

          body: {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
        "password_confirmation": cPassword,
        "device_token": getDeviceToken,
        "gender": gender,
        "birth_date": birthDate,
      },
      ).then((apiRes) {
        print("000 ${apiRes.code}");
        if (apiRes.code == 0) {
          AppStyles.showSweetAlert(
            scaffoldKey.currentState.context,
            subtitle: "عفواً خطأ في البياناتً",
            confirmButtonText: "موافق",
            style: SweetAlertStyle.error,
          );
        }
        if (apiRes.code == 1) {
          AppStyles.showSweetAlert(
            scaffoldKey.currentState.context,
            subtitle: "تم إنشاء حساب بنجاح",
            confirmButtonText: "موافق",
            style: SweetAlertStyle.success,
            onPress: (bool isConfirm) {
              if (isConfirm) {
                AppStyles.showSweetAlert(
                  scaffoldKey.currentState.context,
                  subtitle: "يرجى الإنتظار لحظة ...",
                  style: SweetAlertStyle.loading,
                );
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.pushReplacement(
                    scaffoldKey.currentState.context,
                    PageTransition(
                      type: PageTransitionType.scale,
                      duration: Duration(
                        seconds: 0,
                        milliseconds: 700,
                      ),
                      alignment: Alignment.center,
                      child: OtpVerify(phone: phone),
                    ),
                  );
                });
              }
              return true;
            },
          );
        }
        if (apiRes.code == 2) {
          AppStyles.showSweetAlert(
            scaffoldKey.currentState.context,
            subtitle: "عفوا هذا المستخدم موجود بالفعلً",
            confirmButtonText: "موافق",
            style: SweetAlertStyle.error,
          );
        }
        else{
          print("error sign up " + apiRes.toString());
        }

      });
    } catch (e) {
      print('here');
      AppStyles.showSweetAlert(
        scaffoldKey.currentState.context,
        subtitle: "عفواً خطأ",
        confirmButtonText: "موافق",
        style: SweetAlertStyle.error,
      );
    }
  }

  ///Login Methods
  void login({
    GlobalKey<ScaffoldState> scaffoldKey,
    String phone,
    String password,
  }) async {
    AppStyles.showSweetAlert(
      scaffoldKey.currentState.context,
      subtitle: "يرجى الإنتظار لحظة ...",
      style: SweetAlertStyle.loading,
    );
    try {
      apiHandler.post(
        url: ApiRoutes.login,
        body: {"phone": phone, "password": password},
      ).then((apiRes) async {
        if (apiRes.code == 0) {
          AppStyles.showSweetAlert(
            scaffoldKey.currentState.context,
            subtitle: "عفواً خطأ في البياناتً",
            confirmButtonText: "موافق",
            style: SweetAlertStyle.error,
          );
        }
        if (apiRes.code == 1) {
          final res = apiRes.object as Map<String, dynamic>;
          _id = res["user"]["id"].toString();
          _name = res["user"]["name"];
          _phone = res["user"]["phone"];
          _email = res["user"]["email"];
          _updatedAt = res["user"]["updated_at"];
          _createdAt = res["user"]["created_at"];
          _token = res["token"];
          _otp = res["otp"].toString();
          final object = {
            "id": _id,
            "name": _name,
            "phone": _phone,
            "email": _email,
            "updated_at": _updatedAt,
            "created_at": _createdAt,
            "token": _token,
            "otp": _otp,
          };
          shared.save('userData', object);
          AppStyles.showSweetAlert(
            scaffoldKey.currentState.context,
            subtitle: "تم تسجيل الدخول بنجاح",
            confirmButtonText: "موافق",
            style: SweetAlertStyle.success,
            onPress: (bool isConfirm) {
              if (isConfirm) {
                AppStyles.showSweetAlert(
                  scaffoldKey.currentState.context,
                  subtitle: "يرجى الإنتظار لحظة ...",
                  style: SweetAlertStyle.loading,
                );
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.pushReplacement(
                    scaffoldKey.currentState.context,
                    PageTransition(
                      type: PageTransitionType.scale,
                      duration: Duration(
                        seconds: 0,
                        milliseconds: 700,
                      ),
                      alignment: Alignment.center,
                      child: Home( routeArgument: RouteArgument(param: AppStyles.appArName),),
                    ),
                  );
                });
              }
              return true;
            },
          );
        }
      });
    } catch (e) {
      AppStyles.showSweetAlert(
        scaffoldKey.currentState.context,
        subtitle: "عفواً خطأ",
        confirmButtonText: "موافق",
        style: SweetAlertStyle.error,
      );
    }
  }

  ///Verify Otp Methods
  void verifyOtp({
    GlobalKey<ScaffoldState> scaffoldKey,
    String phone,
    String otp,
  }) async {
    AppStyles.showSweetAlert(
      scaffoldKey.currentState.context,
      subtitle: "يرجى الإنتظار لحظة ...",
      style: SweetAlertStyle.loading,
    );
    try {
      apiHandler.post(
        url: ApiRoutes.otp,
        body: {
          "code": otp,
          "phone": phone,
          "device_token": getDeviceToken,
        },
      ).then((apiRes) async {
        if (apiRes.code == 0) {
          AppStyles.showSweetAlert(
            scaffoldKey.currentState.context,
            subtitle: "عفواً رمز التأكيد غير صحيحً",
            confirmButtonText: "موافق",
            style: SweetAlertStyle.error,
          );
        }
        if (apiRes.code == 1) {
          AppStyles.showSweetAlert(
            scaffoldKey.currentState.context,
            subtitle: "تم تأكيد الرمز بنجاح",
            confirmButtonText: "موافق",
            style: SweetAlertStyle.success,
            onPress: (bool isConfirm) {
              if (isConfirm) {
                AppStyles.showSweetAlert(
                  scaffoldKey.currentState.context,
                  subtitle: "يرجى الإنتظار لحظة ...",
                  style: SweetAlertStyle.loading,
                );
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.pushReplacement(
                    scaffoldKey.currentState.context,
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
                });
              }
              return true;
            },
          );
        }
      });
    } catch (e) {
      AppStyles.showSweetAlert(
        scaffoldKey.currentState.context,
        subtitle: "عفواً خطأ",
        confirmButtonText: "موافق",
        style: SweetAlertStyle.error,
      );
    }
  }

  ///Send Otp Methods
  void sendOtp({
    GlobalKey<ScaffoldState> scaffoldKey,
    String otp,
  }) async {
    AppStyles.showSweetAlert(
      scaffoldKey.currentState.context,
      subtitle: "يرجى الإنتظار لحظة ...",
      style: SweetAlertStyle.loading,
    );
    try {
      apiHandler.postToken(
        url: ApiRoutes.send,
        body: {"code": otp},
      ).then((apiRes) async {
        if (apiRes.code == 1) {
          AppStyles.showSweetAlert(
            scaffoldKey.currentState.context,
            subtitle: "تم إعادة إرسال كود التحقق",
            confirmButtonText: "موافق",
            style: SweetAlertStyle.success,
          );
        }
      });
    } catch (e) {
      AppStyles.showSweetAlert(
        scaffoldKey.currentState.context,
        subtitle: "عفواً خطأ",
        confirmButtonText: "موافق",
        style: SweetAlertStyle.error,
      );
    }
  }

  ///LogOut Methods
  void logOut({GlobalKey<ScaffoldState> scaffoldKey}) async {
    AppStyles.showSweetAlert(
      scaffoldKey.currentState.context,
      subtitle: "يتم تسجيل الخروج ...",
      style: SweetAlertStyle.loading,
    );
    try {
      await shared.clear();
      AppStyles.showSweetAlert(
        scaffoldKey.currentState.context,
        subtitle: "تم تسجيل الخروج بنجاح!",
        confirmButtonText: "موافق",
        style: SweetAlertStyle.success,
        onPress: (isConfirm) {
          if (isConfirm) {
            AppStyles.showSweetAlert(
              scaffoldKey.currentState.context,
              subtitle: "يرجى الإنتظار لحظة ...",
              style: SweetAlertStyle.loading,
            );
            Future.delayed(Duration(seconds: 1), () {
              Navigator.pushReplacement(
                scaffoldKey.currentState.context,
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
            });
          }
        },
      );
    } catch (e) {
      AppStyles.showSweetAlert(
        scaffoldKey.currentState.context,
        subtitle: "عفواً خطأ",
        confirmButtonText: "موافق",
        style: SweetAlertStyle.error,
      );
    }
  }

  ///FCM Listeners and get Device Token
  void fcmListeners() {
    if (Platform.isIOS) iOSPermission();

    _fcm.getToken().then((deviceToken) {
      _deviceToken = deviceToken;
    });
    notifyListeners();
  }

  ///Get IOS Permission
  void iOSPermission() {
    _fcm.setForegroundNotificationPresentationOptions(
      sound: true,
      badge: true,
      alert: true,
    );


    notifyListeners();
  }
}
