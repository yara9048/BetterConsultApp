import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';
import '../../../../Models/Home/User/NavBar/GetDomainsModel.dart';
import '../../../Models/Home/Consultant/ShowMyConsultationsModel.dart';

class GetConsultationsProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<MyConsultations> _data = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<MyConsultations> get data => _data;

  Future<void> fetchDomains() async {
    _isLoading = true;
    _errorMessage = null;
    _data = [];
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    try {
      String url = Endpoints.baseUrl + Endpoints.getConsultation;
      final response = await DioHelper.getData(
        url: url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print(token);
      print(url);
      print(response.data);

      if (response.statusCode == 200) {
       if (response.data is List) {
          _data = (response.data as List)
              .map((item) => MyConsultations.fromJson(item))
              .toList();
        } else if (response.data is Map && response.data['data'] != null) {
          _data = (response.data['data'] as List)
              .map((item) => MyConsultations.fromJson(item))
              .toList();
        } else {
          _errorMessage = 'Unexpected response format';
        }
      } else {
        _errorMessage = 'Failed to fetch domains';
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch domains';
      print('Error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _errorMessage = null;
    _data = [];
    notifyListeners();
  }
}
