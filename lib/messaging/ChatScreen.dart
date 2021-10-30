import 'dart:async';

import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:maosul/provider/socket_provider.dart';
import 'package:provider/provider.dart';

import '../helper/app_styles.dart';
import '../helper/route_argument.dart';
import '../messaging/ChatBubble.dart';

class ChatScreen extends StatefulWidget {
  RouteArgument routeArgument;

  ChatScreen({this.routeArgument});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var provider = Provider.of<SocketProvider>(context, listen: false);
    provider.initDummyUsers();
    provider.connect();
    provider.focusNode.addListener(() {
      if (provider.focusNode.hasFocus) {
        setState(() {
          provider.shows = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SocketProvider>(
      builder: (ctx, appProvider, child) {
        return Stack(
          children: [
            Image.asset(
              "assets/whatsapp_Back.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                elevation: 3,
                title: Text("الدردشة"),
              ),
              body: SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(0.0),
                  child: WillPopScope(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: ListView.builder(
                              cacheExtent: 100,
                              controller: appProvider.controllerScroll,
                              reverse: false,
                              shrinkWrap: true,
                              padding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              itemCount: appProvider.getMessages.length,
                              itemBuilder: (context, i) {
                                Alignment alignment =
                                    appProvider.getMessages[i].type == "source"
                                        ? Alignment.topRight
                                        : Alignment.topLeft;
                                Alignment chatArrowAlignment =
                                    appProvider.getMessages[i].type == "source"
                                        ? Alignment.topRight
                                        : Alignment.topLeft;
                                TextStyle textStyle = TextStyle(
                                  fontSize: 15.0,
                                  color: appProvider.getMessages[i].type ==
                                          "source"
                                      ? Colors.white
                                      : Colors.white,
                                );
                                Color chatBgColor =
                                    appProvider.getMessages[i].type == "source"
                                        ? Color(0xFF128C7E)
                                        : AppStyles.secondColor(1);
                                EdgeInsets edgeInsets =
                                    appProvider.getMessages[i].type == "source"
                                        ? EdgeInsets.fromLTRB(5, 5, 15, 5)
                                        : EdgeInsets.fromLTRB(15, 5, 5, 5);
                                EdgeInsets margins =
                                    appProvider.getMessages[i].type == "source"
                                        ? EdgeInsets.fromLTRB(80, 5, 10, 5)
                                        : EdgeInsets.fromLTRB(10, 5, 80, 5);
                                return Container(
                                  margin: margins,
                                  child: Align(
                                    alignment: alignment,
                                    child: Column(
                                      children: <Widget>[
                                        CustomPaint(
                                          painter: ChatBubble(
                                            color: chatBgColor,
                                            alignment: chatArrowAlignment,
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.all(5),
                                            child: Stack(
                                              children: <Widget>[
                                                Padding(
                                                  padding: edgeInsets,
                                                  child: Text(
                                                    appProvider
                                                        .getMessages[i].message,
                                                    style: textStyle,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Card(
                          elevation: 3,
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    controller: appProvider.controller,
                                    focusNode: appProvider.focusNode,
                                    keyboardType: TextInputType.multiline,
                                    autocorrect: true,
                                    enableSuggestions: true,
                                    textInputAction: TextInputAction.send,
                                    maxLines: 5,
                                    minLines: 1,
                                    autofocus: true,
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        appProvider.onTyping();
                                        setState(() {
                                          appProvider.sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          appProvider.sendButton = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.all(5.0),
                                      hintText: 'إكتب رسالة...',
                                      labelStyle: AppStyles.txtLabelStyle,
                                      hintStyle: AppStyles.txtHintStyle,
                                      prefixIcon: IconButton(
                                        icon: Icon(
                                          appProvider.show
                                              ? Icons.keyboard
                                              : Icons.emoji_emotions_outlined,
                                        ),
                                        onPressed: () {
                                          if (!appProvider.show) {
                                            appProvider.focusNode.unfocus();
                                            appProvider.focusNode
                                                .canRequestFocus = false;
                                          }
                                          setState(() {
                                            appProvider.show =
                                                !appProvider.show;
                                          });
                                        },
                                      ),
                                      border: OutlineInputBorder(
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
                                    style: AppStyles.txtTextFormFieldStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Color(0xFF128C7E),
                                    child: IconButton(
                                      icon: Icon(
                                        appProvider.sendBtn
                                            ? Icons.send
                                            : Icons.mic,
                                        color: Colors.white,
                                      ),
                                      onPressed: () async {
                                        if (appProvider
                                            .controller.text.isEmpty) {
                                          return;
                                        }
                                        appProvider.sendMessage(
                                          appProvider.controller.text,
                                          appProvider.getCurrentUser.id
                                              .toString(),
                                          widget.routeArgument.param.driverID
                                              .toString(),
                                        );
                                        appProvider.controller.clear();
                                        Timer(
                                          Duration(milliseconds: 500),
                                          () => appProvider.controllerScroll
                                              .jumpTo(appProvider
                                                  .controllerScroll
                                                  .position
                                                  .maxScrollExtent),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        appProvider.show
                            ? EmojiPicker(
                                rows: 4,
                                columns: 7,
                                onEmojiSelected: (emoji, category) {
                                  print(emoji);
                                  setState(() {
                                    appProvider.controller.text =
                                        appProvider.controller.text +
                                            emoji.emoji;
                                  });
                                },
                              )
                            : Container()
                      ],
                    ),
                    onWillPop: () {
                      if (appProvider.show) {
                        setState(() {
                          appProvider.show = false;
                        });
                      } else {
                        Navigator.pop(context);
                      }
                      return Future.value(false);
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
