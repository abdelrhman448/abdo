import 'package:flutter/material.dart';
import '../../helper/app_styles.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const CustomButton({
    this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: FlatButton(
        onPressed: onPressed,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.all(10),
        textColor: AppStyles.lineColor(1),
        color: Colors.transparent,
        child: CustomText(
          alignment: Alignment.center,
          text: text,
          color: Colors.white,
        ),
      ),
    );
  }
}
