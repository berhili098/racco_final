// To parse this JSON data, do
//
//     final tUser = tUserFromJson(jsonString);

import 'dart:convert';

TUser tUserFromJson(String str) => TUser.fromJson(json.decode(str));

String tUserToJson(TUser data) => json.encode(data.toJson());

class TUser {
    int? id;
    String? uuid;
    String? firstName;
    String? lastName;
    String? email;
    dynamic emailVerifiedAt;
    String? phoneNo;
    String? profilePicture;
    String? deviceKey;
    int? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    int? technicienId;
    dynamic soustraitantId;
    int? isOnline;
    int? counter;
    Technicien? technicien;

    TUser({
        this.id,
        this.uuid,
        this.firstName,
        this.lastName,
        this.email,
        this.emailVerifiedAt,
        this.phoneNo,
        this.profilePicture,
        this.deviceKey,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.technicienId,
        this.soustraitantId,
        this.isOnline,
        this.counter,
        this.technicien,
    });

    factory TUser.fromJson(Map<String, dynamic> json) => TUser(
        id: json["id"],
        uuid: json["uuid"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        phoneNo: json["phone_no"],
        profilePicture: json["profile_picture"],
        deviceKey: json["device_key"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        technicienId: json["technicien_id"],
        soustraitantId: json["soustraitant_id"],
        isOnline: json["is_online"],
        counter: json["counter"],
        technicien: json["technicien"] == null ? null : Technicien.fromJson(json["technicien"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "phone_no": phoneNo,
        "profile_picture": profilePicture,
        "device_key": deviceKey,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "technicien_id": technicienId,
        "soustraitant_id": soustraitantId,
        "is_online": isOnline,
        "counter": counter,
        "technicien": technicien?.toJson(),
    };
}

class Technicien {
    int? id;
    int? soustraitantId;
    int? userId;
    int? status;
    String? planificationCount;
    int? typeTech;
    String? playerId;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    int? cityId;
    int? conteur;
    int? counter;

    Technicien({
        this.id,
        this.soustraitantId,
        this.userId,
        this.status,
        this.planificationCount,
        this.typeTech,
        this.playerId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.cityId,
        this.conteur,
        this.counter,
    });

    factory Technicien.fromJson(Map<String, dynamic> json) => Technicien(
        id: json["id"],
        soustraitantId: json["soustraitant_id"],
        userId: json["user_id"],
        status: json["status"],
        planificationCount: json["planification_count"],
        typeTech: json["type_tech"],
        playerId: json["player_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        cityId: json["city_id"],
        conteur: json["conteur"],
        counter: json["counter"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "soustraitant_id": soustraitantId,
        "user_id": userId,
        "status": status,
        "planification_count": planificationCount,
        "type_tech": typeTech,
        "player_id": playerId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "city_id": cityId,
        "conteur": conteur,
        "counter": counter,
    };
}
