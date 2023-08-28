class CommunityModel {
  int id;
  String name;
  int adminId;
  List<dynamic> groupsIds;
  String profilePicture;
  String dateCreated;
  int announcement;
  int totalGroups;
  int totalMembers;

  CommunityModel({
    required this.id,
    required this.name,
    required this.adminId,
    required this.groupsIds,
    required this.announcement,
    required this.profilePicture,
    required this.dateCreated,
    required this.totalGroups,
    required this.totalMembers,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> data) {
    return CommunityModel(
      id: data['id'],
      name: data['name'],
      adminId: data['admin'],
      groupsIds: data['members'] ?? [],
      announcement: data['announcement'],
      profilePicture: data['profile_picture'] ?? "",
      totalGroups: data['total_groups'],
      totalMembers: data['total_members'],
      dateCreated: data['date_created'],
    );
  }
}
