class SharedClass {
  static String userId = '';
  static String name = '';
  static String email = '';
  static String roleId = '';
  static String work = '';
  static String fcmToken = '';
  static String userToken = '';

  static Map<String, dynamic> toSharedPreference() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'roleId': roleId,
      'work': work,
      'fcmToken': fcmToken,
      'userToken': userToken,
    };
  }

  static void fromSharedPreference(Map<String, dynamic> map) {
    userId = map['userId'].toString();
    name = map['name'].toString();
    email = map['email'].toString();
    roleId = map['roleId'].toString();
    work = map['work'].toString();
    fcmToken = map['fcmToken'].toString();
    userToken = map['userToken'].toString();
  }
}
