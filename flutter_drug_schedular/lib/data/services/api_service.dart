
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey;

  ApiService(this.apiKey);

  Future<dynamic> fetchPillInfo(String name) async {
    final response = await http.get(
      Uri.parse('http://apis.data.go.kr/1471000/MdcinGrnIdntfcInfoService01?serviceKey=$apiKey&item_name=$name'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load pill info');
    }
  }

  Future<dynamic> fetchHolidayInfo(int year, int month) async {
    final response = await http.get(
      Uri.parse('http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo?solYear=$year&solMonth=$month&ServiceKey=$apiKey'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load holiday info');
    }
  }
}
