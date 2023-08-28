import 'dart:convert';

class User {
  final int id;
  final String firstName, lastName, email, phoneNumber;
  final String profilePicture, username, dateJoined;
  final int totalPost;
  final int totalFollowers;
  final int totalFollowing;
  final String about;

  const User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.dateJoined,
    required this.totalFollowers,
    required this.totalFollowing,
    required this.about,
    required this.totalPost,
  });

  static User fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'] as int,
      username: data['username'] as String,
      firstName: data['first_name'] as String,
      lastName: data['last_name'] as String,
      email: data['email'] as String,
      phoneNumber: data["phone_number"],
      profilePicture: data['profile']['profile_picture'] ?? "",
      about: data['profile']['about'] ?? "",
      totalFollowers: data['total_followers'],
      totalFollowing: data['total_following'],
      totalPost: data['total_posts'],
      dateJoined: data['date_joined'],
    );
  }

  static List<User> fromJSONList(String jsonString) {
    final List<Map<String, dynamic>> data =
        (json.decode(jsonString) as List<dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .toList();
    return data.map((e) => User.fromMap(e)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phoneNumber,
    };
  }

  String toJSON() {
    return json.encode(toMap());
  }
}
