import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:maosul/helper/sharedPref.dart';
import 'package:maosul/model/MessageModel.dart';
import 'package:maosul/model/users_model.dart';
import 'package:maosul/navigation/locator.dart';
import 'package:maosul/navigation/navigation_service.dart';
import 'package:maosul/navigation/route_paths.dart' as routes;
import 'package:maosul/screens/overlay.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../helper/sharedPref.dart';
import '../model/orders_model.dart';
import '../model/users_model.dart';

class SocketProvider extends ChangeNotifier {
  SocketProvider() {
    initDummyUsers();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool show = false;
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();
  IO.Socket socket;
  bool sendBtn = false;
  bool connectedToSocket = false;
  String errorConnectMsg = 'جاري الإتصال...';
  ScrollController controllerScroll = ScrollController();

  set shows(bool val) {
    show = val;
  }

  set sendButton(bool val) {
    sendBtn = val;
  }

  List<MessageModel> messages = [];

  List<MessageModel> get getMessages => messages;
  final User sourceChat = User();

  void initDummyUsers() async {
    final extData = await SharedPref().read('userData');

    var id = extData['id'];
    var name = extData['name'];
    var phone = extData['phone'];
    var email = extData['email'];
    var token = extData['token'];
    sourceChat.id = id;
    sourceChat.name = name;
    sourceChat.email = email;
    sourceChat.phone = phone;
    sourceChat.token = token;
    notifyListeners();
  }

  User get getCurrentUser => sourceChat;

  void connect() {
    socket = IO.io("http://23.111.186.51:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    signin();
    socket.onConnect((data) {
      print("#####\t User with ID of [${getCurrentUser.id}] Connected \t#####");
      onMessage(data);
      onAcceptOrder(data);
      onRejectOrder(data);
    });
    print(socket.connected);
  }

  void signin() {
    socket.emit("signin", getCurrentUser.id);
  }

  void onTyping() {
    print('typing...');
    socket.emit("typing", getCurrentUser.id);
  }

  void setOnTyping() {
    setOnTyping();
    socket.on("typing", (typing) {
      print(
          'typing..............................................................................');
      print(typing);
    });
    notifyListeners();
  }

  void onMessage(data) {
    socket.on("message", (msg) {
      print(msg);
      setMessage("destination", msg["message"]);
      FlutterRingtonePlayer.play(
        android: AndroidSounds.notification,
        ios: IosSounds.receivedMessage,
        looping: false,
        volume: 0.1,
        asAlarm: false,
      );
    });
    Timer(
      Duration(milliseconds: 500),
      () => controllerScroll.jumpTo(controllerScroll.position.maxScrollExtent),
    );
    notifyListeners();
  }

  void sendMessage(String message, String sourceId, String targetId) {
    print({
      "sourceId": sourceId,
      "targetId": targetId,
    });
    setMessage("source", message);
    socket.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
    });

    notifyListeners();
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
      type: type,
      message: message,
    );
    print(messageModel.message);
    messages.add(messageModel);
    Timer(
      Duration(milliseconds: 500),
      () => controllerScroll.jumpTo(controllerScroll.position.maxScrollExtent),
    );
    notifyListeners();
  }

  void _showOverlay(context) {
    Navigator.of(context).push(OverlayPage());
  }

  void sendOrder(
      {GlobalKey<ScaffoldState> scaffoldKey, OrderModel order}) async {
    socket.emit(
      'push_new_order',
      {'orders': order.toMap()},
    );
    _showOverlay(scaffoldKey.currentState.context);
    notifyListeners();
  }

  final NavigationService _navigationService = locator<NavigationService>();

  void onAcceptOrder(data) {
    socket.on("accept_order", (driver) {
      print("###############\t push_new_order \t ###############");
      final response = driver as Map<String, dynamic>;
      print("RESPONSE Map<String, dynamic>  ${response}");
      print("###############\t push_new_order \t ###############");
      print({'driver_accept_order': driver});

      DriverUser driverUser = DriverUser(
        toUserID: response['to_user_id'],
        driverID: response['driver_id'],
      );

      print({'driverUser': driverUser});

      _navigationService.navigateToReplacement(
        routes.ChatScreenRoute,
        arguments: driverUser,
      );
      FlutterRingtonePlayer.play(
        android: AndroidSounds.notification,
        ios: IosSounds.mailSent,
        looping: false,
        volume: 0.1,
        asAlarm: false,
      );
    });

    notifyListeners();
  }

  void onRejectOrder(data) {
    socket.on("reject_order", (driver) {
      print({"driver_reject_order": driver});
    });
    notifyListeners();
  }
}

class DriverUser {
  String toUserID;
  String driverID;

  DriverUser({this.toUserID, this.driverID});
}
