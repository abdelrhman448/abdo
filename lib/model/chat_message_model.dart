import 'dart:convert';

ChatMsgModel chatMessageModelFromJson(String str) =>
    ChatMsgModel.fromJson(json.decode(str));

String chatMessageModelToJson(ChatMsgModel data) => json.encode(data.toJson());

class ChatMsgModel {
  int chatId;
  String to;
  String from;
  String message;
  String chatType;
  bool toUserOnlineStatus;

  ChatMsgModel({
    this.chatId,
    this.to,
    this.from,
    this.message,
    this.chatType,
    this.toUserOnlineStatus,
  });

  factory ChatMsgModel.fromJson(Map<String, dynamic> json) => ChatMsgModel(
        chatId: json["chat_id"],
        to: json["to"],
        from: json["from"],
        message: json["message"],
        chatType: json["chat_type"],
        toUserOnlineStatus: json['to_user_online_status'],
      );

  Map<String, dynamic> toJson() => {
        "chat_id": chatId,
        "to": to,
        "from": from,
        "message": message,
        "chat_type": chatType,
      };
}
