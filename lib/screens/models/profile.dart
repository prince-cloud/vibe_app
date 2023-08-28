import 'package:vibe_app/screens/profile.dart';

class ProfileModel {
  int id;
  String username;
  String email;
  String fullName;
  int totalPost;
  int totalFollowers;
  int tottalFollowing;
  String about;
  String profilePicture;
  String coverPicture;

  ProfileModel({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.totalPost,
    required this.totalFollowers,
    required this.tottalFollowing,
    required this.about,
    required this.profilePicture,
    required this.coverPicture,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> data) {
    return ProfileModel(
      id: data['id'],
      username: data['username'],
      email: data['email'],
      fullName: data['full_name'],
      totalPost: data['total_posts'],
      totalFollowers: data['total_followers'],
      tottalFollowing: data['total_following'],
      about: data['profile']['about'],
      profilePicture: data['profile']['profile_picture'] ?? "",
      coverPicture: data['profile']['cover_picture'] ?? "",
    );
  }
}
