class User {
  String id;
  String? avatar;
  String firstName;
  String lastName;
  String email;
  String role;

  User({
    required this.id,
    required this.avatar,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
  });

  static List<User> fromJsonToList(userDataJson) {
    var list = <User>[];
    for (var usr in userDataJson) {
      list.add(
        User(
          id: usr['id'],
          email: usr['email'],
          firstName: usr['first_name'],
          lastName: usr['last_name'],
          role: usr['role'],
          avatar: usr['avatar'],
        ),
      );
    }
    return list;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
        "role": role,
      };
}
