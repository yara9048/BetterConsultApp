import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';
import '../../../../Models/Home/User/NavBar/FavoriteModel.dart';
import '../../../../Models/Home/User/Others/GetAllConsultant.dart';

class GetFavorite with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<FavoriteModel> _favorites = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<FavoriteModel> get favorites => _favorites;

  Future<void> getFavorite() async {
    _isLoading = true;
    _errorMessage = null;
    _favorites = [];
    notifyListeners();
    final String url = Endpoints.baseUrl + Endpoints.favorite;
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
          _favorites = data.map((item) => FavoriteModel.fromJson(item)).toList();
        } else if (data is Map && data['data'] is List) {
          _favorites = (data['data'] as List).map((item) => FavoriteModel.fromJson(item)).toList();
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
    _favorites = [];
    notifyListeners();
  }
}
