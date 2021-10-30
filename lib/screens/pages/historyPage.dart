import 'package:flutter/material.dart';
import 'package:maosul/localization/localizationSetup/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../helper/app_styles.dart';
import '../../provider/history_provider.dart';
import '../../screens/FadeAnimation.dart';

class History {
  int code;
  String name;
  String time;
  String status;
  String title;
  History({
    this.code,
    this.name,
    this.time,
    this.status,
    this.title,
  });
}

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    var localization=AppLocalization.of(context);
    return Stack(
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
          padding: const EdgeInsets.only(
            top: 3.0,
            left: 0.0,
            right: 0.0,
            bottom: 10.0,
          ),
          child: Consumer<HistoryProvider>(
            builder: (ctx, history, child) {
              return ListView.builder(
                itemCount: history.history.length,
                itemBuilder: (ctx, i) => Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: InkWell(
                    onTap: () => Alert(
                      context: context,
                      type: AlertType.info,
                      style: AppStyles.alertStyle,
                      title: localization.translate('Order Details'),
                      content: Padding(
                        padding: const EdgeInsets.only(
                          top: 1.0,
                          left: 1.0,
                          right: 1.0,
                          bottom: 1.0,
                        ),
                        child: Card(
                          elevation: 3.0,
                          child: Container(
                            width: double.infinity,
                            height: 150.0,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: 20.0, left: 20.0),
                                    child: Center(
                                      child: Text(
                                        "بتاريخ الموافق : 27/7/2020م",
                                        style: AppStyles.txtDateTimeStyle,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    endIndent: 10.0,
                                    indent: 10.0,
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 20.0, left: 20.0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            localization.translate('From'),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 8.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 20.0, left: 20.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "مطعم الضو هجوجا",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 8.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    endIndent: 10.0,
                                    indent: 10.0,
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 20.0, left: 20.0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            localization.translate('Address'),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 8.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 20.0, left: 20.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "الخرطوم بحري",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 8.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    endIndent: 10.0,
                                    indent: 10.0,
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 20.0, left: 20.0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            localization.translate('Order Name Here'),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 8.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 20.0, left: 20.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "إسم الطلب هنا",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 8.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    endIndent: 10.0,
                                    indent: 10.0,
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 20.0, left: 20.0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            localization.translate('Street'),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 8.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 20.0, left: 20.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "عبيد ختم",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 8.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    endIndent: 10.0,
                                    indent: 10.0,
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      buttons: [
                        DialogButton(
                          child: Text(
                            localization.translate('Accept'),
                            style: AppStyles.txtBtnStyle,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: AppStyles.btnColor(1),
                        )
                      ],
                    ).show(),
                    child: FadeAnimation(
                      i == 0
                          ? 0.1
                          : i > 6
                              ? i / 5
                              : i / 3,
                      Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                history.history[i].time,
                                style: AppStyles.txtDateTimeStyle,
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15.0, left: 15.0),
                                child: Text(
                                  history.history[i].title,
                                  style: AppStyles.txtTitleStyle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text(
                                  history.history[i].name,
                                  style: AppStyles.txtLabelStyle,
                                ),
                              ),
                              Divider(),
                              Center(
                                child: Text(
                                  history.history[i].status,
                                  style: TextStyle(
                                    color: history.history[i].code == 1
                                        ? Colors.green
                                        : history.history[i].code == 2
                                            ? Colors.red
                                            : Colors.yellow,
                                    fontSize: 8.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
