// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

CanvasUser userFromJson(String str) => CanvasUser.fromJson(json.decode(str));

String userToJson(CanvasUser data) => json.encode(data.toJson());

class CanvasUser {
  int id;
  String name;
  DateTime createdAt;
  String sortableName;
  String shortName;
  String avatarUrl;
  dynamic locale;
  String effectiveLocale;
  Permissions permissions;

  CanvasUser({
    this.id,
    this.name,
    this.createdAt,
    this.sortableName,
    this.shortName,
    this.avatarUrl,
    this.locale,
    this.effectiveLocale,
//    this.permissions,
  });

  factory CanvasUser.fromJson(Map<String, dynamic> json) => CanvasUser(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    sortableName: json["sortable_name"],
    shortName: json["short_name"],
    avatarUrl: json["avatar_url"],
    locale: json["locale"],
    effectiveLocale: json["effective_locale"],
//    permissions: Permissions.fromJson(json["permissions"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "sortable_name": sortableName,
    "short_name": shortName,
    "avatar_url": avatarUrl,
    "locale": locale,
    "effective_locale": effectiveLocale,
    "permissions": permissions.toJson(),
  };
}

class Permissions {
  bool canUpdateName;
  bool canUpdateAvatar;

  Permissions({
    this.canUpdateName,
    this.canUpdateAvatar,
  });

  factory Permissions.fromJson(Map<String, dynamic> json) => Permissions(
    canUpdateName: json["can_update_name"],
    canUpdateAvatar: json["can_update_avatar"],
  );

  Map<String, dynamic> toJson() => {
    "can_update_name": canUpdateName,
    "can_update_avatar": canUpdateAvatar,
  };
}
