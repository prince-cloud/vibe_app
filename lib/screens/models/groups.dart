class GroupModel {
  int id;
  String name;
  int adminId;
  List<dynamic> membersIds;
  String profilePicture;
  String dateCreated;
  int totalMembers;

  GroupModel({
    required this.id,
    required this.name,
    required this.adminId,
    required this.membersIds,
    required this.profilePicture,
    required this.dateCreated,
    required this.totalMembers,
  });

  factory GroupModel.fromJson(Map<String, dynamic> data) {
    return GroupModel(
      id: data['id'],
      name: data['name'],
      adminId: data['admin'],
      membersIds: data['members'] ?? [],
      totalMembers: data['total_members'],
      profilePicture: data['profile_picture'] ?? "",
      dateCreated: data['date_created'],
    );
  }
}
