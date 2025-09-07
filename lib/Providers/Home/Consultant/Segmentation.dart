import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../../../DIO/DioHelper.dart';
import '../../../DIO/EndPoints.dart';

class Segmentation with ChangeNotifier {
  bool _isLoading = false;
  bool _isSuccess = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  String? get errorMessage => _errorMessage;

  Future<void> runSegmentation(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final String url = Endpoints.baseUrl + Endpoints.segment;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    try {
      final response = await DioHelper.postData(
        url: url,
        headers: {'Authorization': 'Bearer $token'},
        data: FormData.fromMap({'quality_check_id': id}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        _isSuccess = true;
        print(response.data);
      }
    } catch (e, stacktrace) {
      _errorMessage = 'Failed to run segmentation';
      print('Error: $e');
      print(stacktrace);
    }

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _errorMessage = null;
    _isLoading = false;
    _isSuccess = false;
    notifyListeners();
  }
}
