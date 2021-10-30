import 'package:flutter/material.dart';
import 'package:maosul/provider/app_provider.dart';

import '../helper/app_styles.dart';
import '../model/users_model.dart';

class ChatTitle extends StatelessWidget {
  const ChatTitle({
    @required this.chatUser,
    @required this.userOnlineStatus,
  });

  final User chatUser;
  final UserOnlineStatus userOnlineStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            chatUser.name,
            style: AppStyles.txtAppBarStyle,
          ),
          Text(
            _getStatusText(),
            style: AppStyles.txtAppBarStyle,
          )
        ],
      ),
    );
  }

  _getStatusText() {
    if (userOnlineStatus == UserOnlineStatus.connecting) {
      return 'جاري الإتصال...';
    }
    if (userOnlineStatus == UserOnlineStatus.online) {
      return 'متصل الأن';
    }
    if (userOnlineStatus == UserOnlineStatus.not_online) {
      return 'غير متصل';
    }
  }
}
