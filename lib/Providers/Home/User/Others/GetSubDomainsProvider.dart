import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';
import '../../../../Models/Home/User/Others/GeetSubDomainsModel.dart';

class GetSubDomainsProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<GetSubDomainsModel> _domains = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<GetSubDomainsModel> get domains => _domains;

  Future<void> fetchSubDomains({required int id}) async {
    _isLoading = true;
    _errorMessage = null;
    _domains = [];
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    final String Id = id.toString();
    try {
      String url = Endpoints.baseUrl + Endpoints.getSubDomains + Id;
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
        if (response.data is String) {
          _domains = getSubDomainsModelFromJson(response.data);
        } else if (response.data is List) {
          _domains = (response.data as List)
              .map((item) => GetSubDomainsModel.fromJson(item))
              .toList();
        } else if (response.data is Map) {
          _domains = (response.data['data'] as List)
              .map((item) => GetSubDomainsModel.fromJson(item))
              .toList();
        }
      } else {
        _errorMessage = 'Failed to fetch domains';
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch domains';
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
