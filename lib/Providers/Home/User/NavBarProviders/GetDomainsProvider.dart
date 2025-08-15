import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';
import '../../../../Models/Home/User/NavBar/GetDomainsModel.dart';

class GetDomainsProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<GetDomainsModel> _domains = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<GetDomainsModel> get domains => _domains;

  Future<void> fetchDomains() async {
    _isLoading = true;
    _errorMessage = null;
    _domains = [];
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    try {
      String url = Endpoints.baseUrl + Endpoints.getDomains;
      final response = await DioHelper.getData(
        url: url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print(token);
      print(url);
      print(response.data); // Add this to see the actual response structure

      if (response.statusCode == 200) {
        if (response.data is String) {
          _domains = getDomainsModelFromJson(response.data);
        } else if (response.data is List) {
          // If the response is already a List, convert it directly
          _domains = (response.data as List)
              .map((item) => GetDomainsModel.fromJson(item))
              .toList();
        } else if (response.data is Map) {
          // If the response is a Map with a data field containing the list
          _domains = (response.data['data'] as List)
              .map((item) => GetDomainsModel.fromJson(item))
              .toList();
        }
      } else {
        _errorMessage = 'Failed to fetch domains: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch domains: $e';
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _errorMessage = null;
    _domains = [];
    notifyListeners();
  }
}
