
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sweetalert/sweetalert.dart';

class AppStyles {
  ///app settings
  static String appArName = "موصول";
  static String appEnName = "موصول";
  static String appPackage = "com.maosul.maosul";
  static String msg91AuthKey = "";
  static String appAbout = "";
  static String appPrivacy = "";

  static Color mainColor(double opacity) {
    try {
      return Color(0xFF000744).withOpacity(opacity);
    } catch (e) {
      return Color(0xFF00215C).withOpacity(opacity);
    }
  }

  static Color secondColor(double opacity) {
    try {
      return Color(0xFF003575).withOpacity(opacity);
    } catch (e) {
      return Color(0xFF0063AA).withOpacity(opacity);
    }
  }

  static Color accentColor(double opacity) {
    try {
      return Color(0xFF00B0FF).withOpacity(opacity);
    } catch (e) {
      return Color(0xFF003575).withOpacity(opacity);
    }
  }

  static Color scaffoldColor(double opacity) {
    try {
      return Color(0xFFFFFFFF).withOpacity(opacity);
    } catch (e) {
      return Color(0xFFFFFFFF).withOpacity(opacity);
    }
  }

  static Color btnColor(double opacity) {
    try {
      return Color(0xFF00215C).withOpacity(opacity);
    } catch (e) {
      return Color(0xFF003575).withOpacity(opacity);
    }
  }

  static Color iconColor(double opacity) {
    try {
      return Color(0xFF000744).withOpacity(opacity);
    } catch (e) {
      return Color(0xFF00215C).withOpacity(opacity);
    }
  }

  static Color lineColor(double opacity) {
    try {
      return Color(0xFFFF0000).withOpacity(opacity);
    } catch (e) {
      return Color(0xFFFF1919).withOpacity(opacity);
    }
  }

  ThemeData theme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppStyles.mainColor(1),
    backgroundColor: AppStyles.secondColor(1),
    accentColor: AppStyles.accentColor(1),
    cursorColor: AppStyles.mainColor(1),
    scaffoldBackgroundColor: AppStyles.scaffoldColor(1),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Fairuz',
    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppStyles.mainColor(1),
      ),
      titleTextStyle: headline,
      toolbarTextStyle: headline,

      // textTheme: TextTheme(
      //   headline: headline,
      //   display1: display1,
      //   display2: display2,
      //   display3: display3,
      //   display4: display4,
      //   body1: body1,
      //   body2: body2,
      //   title: title,
      // ),
    ),
  );

  static TextStyle headline = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w800,
  );

  static TextStyle display1 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: AppStyles.secondColor(1),
  );

  static TextStyle display2 = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w700,
    color: AppStyles.secondColor(1),
  );

  static TextStyle display3 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    color: AppStyles.mainColor(1),
  );

  static TextStyle display4 = TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.w300,
    color: AppStyles.secondColor(1),
  );

  static TextStyle subhead = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: AppStyles.secondColor(1),
  );

  static TextStyle title = TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.w700,
    color: AppStyles.mainColor(1),
  );

  static TextStyle body1 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: AppStyles.secondColor(1),
  );

  static TextStyle body2 = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w400,
    color: AppStyles.secondColor(1),
  );

  static TextStyle caption = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w300,
    color: AppStyles.accentColor(1),
  );

  static TextStyle txtBtnStyle = TextStyle(
    color: Colors.white,
  );

  static TextStyle txtTitleStyle = TextStyle(
    color: AppStyles.mainColor(1),
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle txtLabelStyle = TextStyle(
    color: Colors.black,
    fontSize: 12.0,
  );

  static TextStyle txtHintStyle = TextStyle(
    color: Colors.grey,
    fontSize: 8.0,
  );

  static TextStyle txtTextFormFieldStyle = TextStyle(
    fontSize: 15.0,
  );

  static TextStyle txtHintChatStyle = TextStyle(
    color: Colors.black,
    fontSize: 12.0,
  );

  static TextStyle txtAppBarStyle = TextStyle(
    fontSize: 12,
    color: Colors.black,
    fontFamily: 'Fairuz',
  );

  static TextStyle drawerHeaderTxtColor = TextStyle(
    color: Colors.white,
  );

  static TextStyle drawerTxtColor = TextStyle(
    color: AppStyles.mainColor(1),
  );

  static TextStyle txtDateTimeStyle = TextStyle(
    fontSize: 8,
    color: Colors.green,
  );

  static TextStyle txtNameStyle = TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static AlertStyle alertStyle = AlertStyle(
    animationType: AnimationType.shrink,
    isCloseButton: true,
    isOverlayTapDismiss: true,
    descStyle: TextStyle(),
    animationDuration: Duration(milliseconds: 100),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: AppStyles.btnColor(0),
    ),
  );

  static showSweetAlert(
    BuildContext context, {
    String title,
    String subtitle,
    SweetAlertStyle style,
    String confirmButtonText,
    Function onPress,
  }) {
    SweetAlert.show(
      context,
      title: title,
      subtitle: subtitle,
      style: style,
      confirmButtonText: confirmButtonText,
      confirmButtonColor: AppStyles.mainColor(1),
      cancelButtonColor: AppStyles.mainColor(1),
      onPress: onPress,
    );
  }
}
