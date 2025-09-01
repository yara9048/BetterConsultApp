import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';
import '../../../../Models/Home/User/Others/ConsultantDetailsModel.dart';
import '../../../../Models/Home/User/Others/GetAllConsultant.dart';

class ConsultantDetailsProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<ConsultandDetailsModel> _details = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<ConsultandDetailsModel> get details => _details;

  Future<void> fetchDetails({required id}) async {
    _isLoading = true;
    _errorMessage = null;
    _details = [];
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    try {
      final String url = '${Endpoints.baseUrl + Endpoints.consultantDetails}$id/';
      final response = await DioHelper.getData(
        url: url,
        headers: {'Authorization': 'Bearer $token'},
      );

      print('--- API Response ---');
      print('Status code: ${response.statusCode}');
      print('Response data type: ${response.data.runtimeType}');
      print('Response data: ${response.data}');
      if (response.statusCode == 200) {
        final data = response.data;

        if (data is List) {
          _details = data.map((item) => ConsultandDetailsModel.fromJson(item)).toList();
        } else if (data is Map) {
          if (data['data'] is List) {
            _details = (data['data'] as List).map((item) => ConsultandDetailsModel.fromJson(item)).toList();
          } else {
            _details = [ConsultandDetailsModel.fromJson(response.data)];
          }
        } else {
          _errorMessage = 'Unexpected response format: ${data.runtimeType}';
          print('Unexpected response content: $data');
        }

    } else if (response.statusCode == 404) {
        _errorMessage = 'No consultants here';
      } else {
        _errorMessage = 'Failed to fetch consultants (Error ${response.statusCode})';
      }
    } catch (e, stacktrace) {
      _errorMessage = 'Failed to fetch consultants';
      print('Error fetching consultants: $e');
      print(stacktrace);
    }

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _errorMessage = null;
    _details = [];
    notifyListeners();
  }
}
