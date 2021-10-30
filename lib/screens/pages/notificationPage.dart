import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';

import '../../helper/app_styles.dart';
import '../../provider/notification_provider.dart';
import '../../screens/FadeAnimation.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
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
          child: Consumer<NotificationProvider>(
            builder: (ctx, notification, child) {
              return ListView.builder(
                itemCount: notification.getNotifications.length,
                itemBuilder: (ctx, i) {
                  return FadeAnimation(
                    i == 0
                        ? 0.1
                        : i > 6
                            ? i / 5
                            : i / 3,
                    Card(
                      color: Colors.white,
                      elevation: 3,
                      child: ListTile(
                        onTap: () {},
                        title: Text(
                          notification.getNotifications[i].title,
                          style: TextStyle(

                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                        subtitle: Text(
                          notification.getNotifications[i].body,
                          style: TextStyle(

                            color: Colors.black,
                            fontSize: 8.0,
                          ),
                        ),
                        leading: notification.getNotifications[i].type == 1
                            ? Icon(
                          Icons.notifications_active,
                          color: Colors.red,
                        )
                            : notification.getNotifications[i].type == 2
                            ? Icon(
                          Icons.notifications_active,
                          color: Colors.yellow,
                        )
                            : Icon(
                          Icons.notifications_active,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}