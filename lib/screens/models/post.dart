class PostModel {
  int id;
  String text;
  Map<String, dynamic> userAccount;
  bool liked;
  int likesCount;
  int commentCount;
  List<dynamic> pictures = [];
  List<dynamic> videos = [];
  String postType;
  int sharesCount;
  int sharedFrom;
  bool isEdited;
  String dateCreated;

  PostModel({
    required this.id,
    required this.text,
    required this.userAccount,
    required this.liked,
    required this.likesCount,
    required this.commentCount,
    required this.pictures,
    required this.videos,
    required this.postType,
    required this.sharesCount,
    required this.sharedFrom,
    required this.isEdited,
    required this.dateCreated,
  });

  factory PostModel.fromJson(Map<String, dynamic> data) {
    return PostModel(
      id: data['id'],
      text: data['text'],
      userAccount: data['user_account'],
      liked: data['liked'],
      likesCount: data['likes_count'],
      commentCount: data['comment_count'],
      pictures: data['pictures'],
      videos: data['videos'],
      postType: data['post_type'],
      sharesCount: data['shares_count'],
      sharedFrom: data['shared_from'] ?? 0,
      isEdited: data['is_edited'],
      dateCreated: data['date_created'],
    );
  }
}
