
import '../../data/services/api_service.dart';

class SearchPillInfo {
  final ApiService apiService;

  SearchPillInfo(this.apiService);

  Future<dynamic> call(String name) async {
    return await apiService.fetchPillInfo(name);
  }
}
