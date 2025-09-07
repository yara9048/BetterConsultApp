import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';
import '../../../../Models/Home/User/NavBar/GetDomainsModel.dart';
import '../../../../Models/Home/User/NavBar/TopRatedModel.dart';

class GetTopRated with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<TopRatedModel> _consulters = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<TopRatedModel> get consulters => _consulters;

  Future<void> fetchTopRated() async {
    _isLoading = true;
    _errorMessage = null;
    _consulters = [];
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    try {
      String url = Endpoints.baseUrl + Endpoints.topRated;
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
          _consulters = (response.data as List)
              .map((item) => TopRatedModel.fromJson(item))
              .toList();
        } else if (response.data is Map && response.data['data'] != null) {
          _consulters = (response.data['data'] as List)
              .map((item) => TopRatedModel.fromJson(item))
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
    _consulters = [];
    notifyListeners();
  }
}
