import 'package:dio/dio.dart' as dio;
import 'package:vnica_app/app/data/models/dropdown/response_dropdown.dart';
import 'package:vnica_app/app/data/provider/api_provider.dart';

class ApiDropdownData {
  Map<dynamic, dynamic>? filter;
  String? endpoint;
  ApiDropdownData({this.filter, this.endpoint});
  Future<List<Map<String, String>>> _getDropdownData({
    required String endpoint,
    Map<dynamic, dynamic>? filter,
  }) async {
    try {
      final response = await ApiProvider.instance().get(
        '$endpoint/dropdown',
        queryParameters: {"filter": filter},
        options: dio.Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
        ),
      );

      if (response.statusCode == 200) {
        final ResponseDropdown responseDropdown =
            ResponseDropdown.fromJson(response.data);

        return responseDropdown.convertDropdown();
      } else {
        return [];
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        return [];
      } else {
        print(e.message);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    } finally {
      print("selesai ambil data dropdown");
    }
  }

  Future<List<Map<String, String>>> getDropdownData() => _getDropdownData(
        endpoint: endpoint ?? "",
        filter: filter,
      );
}
