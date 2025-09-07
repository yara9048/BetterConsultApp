import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';
import '../../../Models/Home/Consultant/WaitingListModel.dart';

class WaitingListProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  WaitingListModel? _list;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // FIXED: Return _list instead of calling list recursively
  WaitingListModel? get list => _list;

  Future<void> fetchWaitingList() async {
    _isLoading = true;
    _errorMessage = null;
    _list = null;
    notifyListeners();

    print("🔵 [Provider] fetchWaitingList() called...");

    String url = Endpoints.baseUrl + Endpoints.waitingList;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    print("🟡 [Provider] Token: $token");
    print("🟡 [Provider] URL: $url");

    try {
      final response = await DioHelper.getData(
        url: url,
        headers: {'Authorization': 'Bearer $token'},
      );

      print("🟢 [Provider] Response Status: ${response.statusCode}");
      print("🟢 [Provider] Response Data: ${response.data}");

      if (response.statusCode == 200) {
        if (response.data is String) {
          final decoded = jsonDecode(response.data);
          _list = WaitingListModel.fromJson(decoded);
        } else if (response.data is Map<String, dynamic>) {
          _list = WaitingListModel.fromJson(response.data);
        } else {
          print("🔴 [Provider] Unexpected response type: ${response.data.runtimeType}");
        }
      } else {
        _errorMessage = 'Failed to fetch waiting list (status: ${response.statusCode})';
        print("🔴 [Provider] Error: $_errorMessage");
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch waiting list: ${e.toString()}';
      print("🔴 [Provider] Exception: $e");
    }

    if (_list == null) {
      print("⚠️ [Provider] Waiting list is still null.");
    }

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _errorMessage = null;
    _list = null;
    notifyListeners();
  }
}
