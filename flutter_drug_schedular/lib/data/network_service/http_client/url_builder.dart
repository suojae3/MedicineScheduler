
import 'package:flutter_drug_schedular/data/network_service/http_client/i_url_builder.dart';

class UrlBuilder implements IUrlBuilder {
  final String scheme;
  final String host;
  final int? port;

  UrlBuilder({
    required this.scheme,
    required this.host,
    this.port,
  });

  @override
  Uri buildEndpoint(String endpoint, {Map<String, String>? queryParams}) {
    return Uri(
      scheme: scheme,
      host: host,
      port: port,
      path: endpoint,
      queryParameters: queryParams,
    );
  }
}
