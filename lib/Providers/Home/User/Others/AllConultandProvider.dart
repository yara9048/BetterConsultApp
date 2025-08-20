import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';
import '../../../../Models/Home/User/NavBar/GetAllConsultant.dart';

class AllConsultantProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<GetAllConsultant> _consultants = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<GetAllConsultant> get consultants => _consultants;

  Future<void> fetchConsultant({required domainId, required subDomainId}) async {
    _isLoading = true;
    _errorMessage = null;
    _consultants = [];
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    try {
      final String url = '${Endpoints.baseUrl + Endpoints.allConsultantByDomain}$domainId/$subDomainId/';
      final response = await DioHelper.getData(
        url: url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List) {
          _consultants = data.map((item) => GetAllConsultant.fromJson(item)).toList();
        } else if (data is Map && data['data'] is List) {
          _consultants = (data['data'] as List).map((item) => GetAllConsultant.fromJson(item)).toList();
        } else {
          _errorMessage = 'Unexpected response format';
        }
      }
      else if (response.statusCode == 404) {
        _errorMessage = 'No consultants here';
      }
      else {
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
    _consultants = [];
    notifyListeners();
  }
}
