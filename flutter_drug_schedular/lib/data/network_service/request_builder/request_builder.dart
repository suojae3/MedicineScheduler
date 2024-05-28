



import 'package:flutter_drug_schedular/data/network_service/request_builder/IRequestBuilder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class RequestBuilder implements IRequestBuilder {
  @override
  http.Request buildGetRequest(Uri url) {
    return http.Request('GET', url);
  }

  @override
  http.Request buildPostRequest(Uri url, Map<String, String> headers, dynamic body) {
    final request = http.Request('POST', url);
    request.headers.addAll(headers);
    request.body = jsonEncode(body);
    return request;
  }
}
