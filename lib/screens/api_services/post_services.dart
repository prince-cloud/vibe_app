import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:vibe_app/screens/api_services/base.dart';
import 'package:vibe_app/screens/models/post.dart';

class PostServices {
  Future<ApiClientListResult<PostModel>> getPosts({
    String? url,
  }) async {
    http.Response response;
    String apiUrl = url ?? URLS.getPost;
    try {
      response = await http.get(
        Uri.parse(apiUrl),
        headers: serviceHeaders,
      );
    } on SocketException catch (_) {
      throw NetworkFailure("Sorry there is no internet connection.");
    }
    List<PostModel> posts = [];
    Map responseData = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    for (Map<String, dynamic> post in responseData['results']) {
      posts.add(PostModel.fromJson(post));
    }
    ApiClientListResult<PostModel> postResults = ApiClientListResult<PostModel>(
      count: responseData['count'],
      next: responseData['next'],
      previous: responseData['previous'],
      result: posts,
    );
    return postResults;
  }

  Future<List<PostModel>> getPostWithSearchTerm({
    required String searchTerm,
  }) async {
    http.Response response;

    Uri apiUrl = Uri.http(
      hostAddressOnly,
      "/post/v1/posts",
      {"search": searchTerm},
    );
    try {
      response = await http.get(
        apiUrl,
        headers: serviceHeaders,
      );
    } on SocketException catch (_) {
      return [];
    }
    List<PostModel> posts = [];
    Map responseData = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    for (Map<String, dynamic> post in responseData['results']) {
      posts.add(PostModel.fromJson(post));
    }
    return posts;
  }
}
