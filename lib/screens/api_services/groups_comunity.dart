import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:vibe_app/screens/api_services/base.dart';
import 'package:vibe_app/screens/models/community.dart';
import 'package:vibe_app/screens/models/groups.dart';

class GroupCommunityServices {
  Future<ApiClientListResult<GroupModel>> getGroups({
    String? url,
  }) async {
    http.Response response;
    String apiUrl = url ?? URLS.getGroups;
    try {
      response = await http.get(
        Uri.parse(apiUrl),
        headers: serviceHeaders,
      );
    } on SocketException catch (_) {
      throw NetworkFailure("Sorry there is no internet connection.");
    }
    List<GroupModel> groups = [];
    Map responseData = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    for (Map<String, dynamic> group in responseData['results']) {
      groups.add(GroupModel.fromJson(group));
    }
    ApiClientListResult<GroupModel> groupResults =
        ApiClientListResult<GroupModel>(
      count: responseData['count'],
      next: responseData['next'],
      previous: responseData['previous'],
      result: groups,
    );
    return groupResults;
  }

  Future<ApiClientListResult<CommunityModel>> getCommunities({
    String? url,
  }) async {
    http.Response response;
    String apiUrl = url ?? URLS.getCommunities;
    try {
      response = await http.get(
        Uri.parse(apiUrl),
        headers: serviceHeaders,
      );
    } on SocketException catch (_) {
      throw NetworkFailure("Sorry there is no internet connection.");
    }
    List<CommunityModel> communities = [];
    Map responseData = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    for (Map<String, dynamic> community in responseData['results']) {
      communities.add(CommunityModel.fromJson(community));
    }
    ApiClientListResult<CommunityModel> communityResults =
        ApiClientListResult<CommunityModel>(
      count: responseData['count'],
      next: responseData['next'],
      previous: responseData['previous'],
      result: communities,
    );
    return communityResults;
  }

  Future<List<GroupModel>> getGroupWithSearchTerm({
    required String searchTerm,
  }) async {
    http.Response response;
    Uri apiUrl = Uri.http(
      hostAddressOnly,
      "/community/v1/groups",
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
    List<GroupModel> groups = [];
    Map responseData = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    for (Map<String, dynamic> group in responseData['results']) {
      groups.add(GroupModel.fromJson(group));
    }
    return groups;
  }
}
