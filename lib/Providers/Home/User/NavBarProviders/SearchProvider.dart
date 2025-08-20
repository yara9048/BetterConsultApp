import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/Models/Home/User/NavBar/SearchModel.dart';
import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';

class SearchProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<SearchModel> _results = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<SearchModel> get results => _results;

  Future<void> getFavorite({required String query}) async {
    _isLoading = true;
    _errorMessage = null;
    _results = [];
    notifyListeners();
    final String url = Endpoints.baseUrl + Endpoints.search+query;
    print(url);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    print(token);
    try {
      final response = await DioHelper.getData(
        url: url,
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.data);
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List) {
          _results = data.map((item) => SearchModel.fromJson(item)).toList();
        } else if (data is Map && data['data'] is List) {
          _results = (data['data'] as List).map((item) => SearchModel.fromJson(item)).toList();
        } else {
          _errorMessage = 'Unexpected response format';
        }
      }
      else if (response.statusCode == 404) {
        _errorMessage = 'No consultants here';
      }
      else {
        _errorMessage =
        'Failed to fetch consultants (Error ${response.statusCode})';
      }} catch (e, stacktrace) {
      _errorMessage = 'Failed to fetch consultants';
      print('Error fetching consultants: $e');
      print(stacktrace);
    }

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _errorMessage = null;
    _results = [];
    notifyListeners();
  }
}
