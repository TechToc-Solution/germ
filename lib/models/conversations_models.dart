import 'dart:convert';

Positions positionsFromJson(String str) => Positions.fromJson(json.decode(str));

String positionsToJson(Positions data) => json.encode(data.toJson());

class Positions {
  PositionsUser user;
  List<Conversation> conversations;

  Positions({
    required this.user,
    required this.conversations,
  });

  factory Positions.fromJson(Map<String, dynamic> json) => Positions(
        user: PositionsUser.fromJson(json["user"]),
        conversations: List<Conversation>.from(
            json["conversations"].map((x) => Conversation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "conversations":
            List<dynamic>.from(conversations.map((x) => x.toJson())),
      };
}

class Conversation {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  List<Participant> participants;

  Conversation({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.participants,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        participants: List<Participant>.from(
            json["participants"].map((x) => Participant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
      };
}

class Participant {
  int id;
  int conversationId;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  ParticipantUser user;

  Participant({
    required this.id,
    required this.conversationId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        id: json["id"],
        conversationId: json["conversation_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: ParticipantUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "conversation_id": conversationId,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
      };
}

class ParticipantUser {
  int id;
  int roleId;
  String name;
  String email;
  String avatar;
  String work;
  dynamic emailVerifiedAt;
  dynamic fcmToken;
  List<dynamic> settings;
  DateTime createdAt;
  DateTime updatedAt;

  ParticipantUser({
    required this.id,
    required this.roleId,
    required this.name,
    required this.email,
    required this.avatar,
    required this.work,
    required this.emailVerifiedAt,
    required this.fcmToken,
    required this.settings,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ParticipantUser.fromJson(Map<String, dynamic> json) =>
      ParticipantUser(
        id: json["id"],
        roleId: json["role_id"],
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        work: json["work"],
        emailVerifiedAt: json["email_verified_at"],
        fcmToken: json["fcm_token"],
        settings: List<dynamic>.from(json["settings"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "name": name,
        "email": email,
        "avatar": avatar,
        "work": work,
        "email_verified_at": emailVerifiedAt,
        "fcm_token": fcmToken,
        "settings": List<dynamic>.from(settings.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class PositionsUser {
  int id;
  int roleId;
  String name;
  String email;
  String avatar;
  dynamic work;
  dynamic emailVerifiedAt;
  dynamic fcmToken;
  Settings settings;
  DateTime createdAt;
  DateTime updatedAt;

  PositionsUser({
    required this.id,
    required this.roleId,
    required this.name,
    required this.email,
    required this.avatar,
    required this.work,
    required this.emailVerifiedAt,
    required this.fcmToken,
    required this.settings,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PositionsUser.fromJson(Map<String, dynamic> json) => PositionsUser(
        id: json["id"],
        roleId: json["role_id"],
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        work: json["work"],
        emailVerifiedAt: json["email_verified_at"],
        fcmToken: json["fcm_token"],
        settings: Settings.fromJson(json["settings"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "name": name,
        "email": email,
        "avatar": avatar,
        "work": work,
        "email_verified_at": emailVerifiedAt,
        "fcm_token": fcmToken,
        "settings": settings.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Settings {
  String locale;

  Settings({
    required this.locale,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        locale: json["locale"],
      );

  Map<String, dynamic> toJson() => {
        "locale": locale,
      };
}
