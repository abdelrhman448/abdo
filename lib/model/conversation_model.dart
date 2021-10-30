// To parse this JSON data, do
//
//     final conversation = conversationFromMap(jsonString);

import 'dart:convert';

Conversation conversationFromMap(String str) =>
    Conversation.fromMap(json.decode(str));

String conversationToMap(Conversation data) => json.encode(data.toMap());

class Conversation {
  Conversation({
    this.name,
    this.message,
  });

  String name;
  String message;

  factory Conversation.fromMap(Map<String, dynamic> json) => Conversation(
        name: json["name"] == null ? null : json["name"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "message": message == null ? null : message,
      };
}
