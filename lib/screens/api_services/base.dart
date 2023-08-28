// ignore: constant_identifier_names
const hostUrl = 'http://172.20.10.9:8000';
const hostAddressOnly = '172.20.10.9:8000';

///serviceHeaders are headers used globally.
Map<String, String> serviceHeaders = {
  "CONTENT-TYPE": "application/json",
};

///headersNoContentType are headers without the content type
///
Map<String, String> get headersNoContentType =>
    {...serviceHeaders}..remove("CONTENT-TYPE");

class URLS {
  static const register = "$hostUrl/auth/v1/register/";
  static const getToken = "$hostUrl/auth/v1/token/";
  static const refreshToken = "$hostUrl/auth/v1/token/refresh/";
  static const getPost = "$hostUrl/post/v1/posts/";
  static const getProfile = "$hostUrl/auth/v1/users/profile/";
  static const getGroups = "$hostUrl/community/v1/groups/";
  static const getCommunities = "$hostUrl/community/v1/community/";
}

class NetworkFailure {
  final String _message;
  NetworkFailure(this._message);

  @override
  String toString() {
    return _message;
  }
}

class ApiClientListResult<T> {
  String? next;
  String? previous;
  int? count;
  List<T> result = [];

  ApiClientListResult(
      {this.next, this.previous, this.count, required this.result});
}
