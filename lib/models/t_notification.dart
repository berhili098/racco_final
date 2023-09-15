// To parse this JSON data, do
//
//     final tNotication = tNoticationFromJson(jsonString);

import 'dart:convert';

TNotication tNoticationFromJson(String str) => TNotication.fromJson(json.decode(str));

String tNoticationToJson(TNotication data) => json.encode(data.toJson());

class TNotication {
    int? id;
    String? uuid;
    String? title;
    String? createdAt;
    String? updatedAt;
    String? userId;
    String? data;

    TNotication({
        this.id,
        this.uuid,
        this.title,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.data,
    });

    factory TNotication.fromJson(Map<String, dynamic> json) => TNotication(
        id: json["id"],
        uuid: json["uuid"],
        title: json["title"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        userId: json["userId"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "title": title,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "userId": userId,
        "data": data,
    };
}
