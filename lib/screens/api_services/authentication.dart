import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:vibe_app/screens/api_services/base.dart';
import 'package:vibe_app/screens/models/profile.dart';
import 'package:vibe_app/screens/models/user.dart';

class AuthenticationService {
  static Future<Map<String, dynamic>> register(
      {required String phoneNumber,
      required String password,
      required String username,
      required String firstName}) async {
    http.Response response;
    print("executing");
    try {
      response = await http.post(
        Uri.parse(URLS.register),
        headers: serviceHeaders,
        body: jsonEncode({
          'phone_number': phoneNumber,
          'password': password,
          'username': username,
          'first_name': firstName,
          'last_name': '',
        }),
      );
      print(response.body);

      if (response.statusCode == 500) {
        throw "An error occurred";
      }
      final Map jsonData = jsonDecode(response.body) as Map;
      print(response.body);
      return jsonData.cast<String, dynamic>();
    } on http.ClientException {
      throw "Bad Internet connection";
    }
  }

  static Future<Map<String, dynamic>> login(
      {required String username, required String password}) async {
    http.Response response;
    try {
      response = await http.post(
        Uri.parse(URLS.getToken),
        headers: serviceHeaders,
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 500) {
        throw "An error occurred";
      }
      final Map jsonData = jsonDecode(response.body) as Map;
      print(response.body);
      return jsonData.cast<String, dynamic>();
    } on http.ClientException {
      throw "Bad Internet connection";
    }
  }

  activateAccount({required String otp, required String phoneNumber}) async {
    http.Response response;
    try {
      response = await http.post(
        Uri.parse('$hostUrl/auth/v1/register/activate/'),
        body: {'otp': otp, 'phone_number': phoneNumber},
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      print(data);
      if (response.statusCode == 200) {
        print("====== status code: ${response.statusCode}");
        return response.statusCode;
      }
      return data;
    } on http.ClientException {
      throw "Bad Internet connection";
    }
  }

  getUserWithId({required int id}) async {
    try {
      final response = await http.get(
        Uri.parse('$hostUrl/auth/v1/users/$id/'),
        headers: serviceHeaders,
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final User user = User.fromMap(data);
        return user;
      }
      return response.statusCode;
    } on http.ClientException {
      throw "Bad Internet connection";
    }
  }

  updateUserDetails({
    required int id,
    String? firstName,
    lastName,
    email,
    required String imageUrl,
  }) async {
    http.MultipartRequest request = http.MultipartRequest(
      'PATCH',
      Uri.parse(
        "$hostUrl/auth/v1/users/$id/",
      ),
    )
      ..fields['first_name'] = firstName.toString()
      ..fields['last_name'] = lastName.toString()
      ..fields['email'] = email ?? "";
    if (imageUrl.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath('picture', imageUrl),
      );
    }

    request.headers.addAll(serviceHeaders);

    http.StreamedResponse response;
    try {
      response = await request.send();
    } on http.ClientException {
      throw "Bad Internet connection";
    }
    String responseValue = await response.stream.bytesToString();
    return json.decode(responseValue);
  }

  updateEmail({required String email}) async {
    http.Response response;
    try {
      response = await http.post(
        Uri.parse('$hostUrl/auth/v1/users/update-email/'),
        body: json.encode({'email': email}),
        headers: serviceHeaders,
      );
      final data = json.decode(response.body);
      return data;
    } on http.ClientException {
      throw "Bad Internet connection";
    }
  }

  resendOtp({required String phoneNumber}) async {
    http.Response response;
    try {
      response = await http.post(
        Uri.parse('$hostUrl/auth/v1/register/resend-otp/'),
        body: json.encode({'phone_number': phoneNumber}),
        headers: serviceHeaders,
      );
      final data = json.decode(response.body);
      return data;
    } on http.ClientException {
      throw "Bad Internet connection";
    }
  }

  getProfile() async {
    try {
      final response = await http.get(
        Uri.parse(URLS.getProfile),
        headers: serviceHeaders,
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final ProfileModel profile = ProfileModel.fromJson(data);
        return profile;
      }
      return response.statusCode;
    } on http.ClientException {
      throw "Bad Internet connection";
    }
  }

  Future<List<User>> getUserWithSearchTerm({
    required String searchTerm,
  }) async {
    http.Response response;

    Uri apiUrl = Uri.http(
      hostAddressOnly,
      "/auth/v1/users",
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
    List<User> users = [];
    Map responseData = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    for (Map<String, dynamic> user in responseData['results']) {
      users.add(User.fromMap(user));
    }
    return users;
  }
}
