


import 'package:http/http.dart' as http;

abstract class IRequestBuilder {
  http.Request buildGetRequest(Uri url);
  http.Request buildPostRequest(Uri url, Map<String, String> headers, dynamic body);
}
