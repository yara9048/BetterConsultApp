import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../../../DIO/DioHelper.dart';
import '../../../DIO/EndPoints.dart';

class IdTextChechQuality with ChangeNotifier {
  bool _isLoading = false;
  bool _isSuccess = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  String? get errorMessage => _errorMessage;

  Future<void> idtextCheckQuality(int id, String ansewr) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final String url = Endpoints.baseUrl + Endpoints.answeringWaitingText;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    print(url);
    try {
      final response = await DioHelper.postData(
        url: url,
        headers: {'Authorization': 'Bearer $token'},
        data: FormData.fromMap({
          'answer':ansewr,
          'waiting_question_id':id
        }),
      );

      if (response.statusCode == 201) {
        _isSuccess = true;
        final data = response.data;
        print(data);

      }

    } catch (e, stacktrace) {
      _errorMessage = 'Failed to check quality';
      print('Error checking quality: $e');
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
