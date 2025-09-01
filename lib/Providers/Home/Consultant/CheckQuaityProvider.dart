import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';
import '../../../../Models/Home/Consultant/quaityDataModel.dart';

class CheckQuaityProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<QualityData> _data = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<QualityData> get data => _data;

  Future<void> checkQuality(File video) async {
    _isLoading = true;
    _errorMessage = null;
    _data = [];
    notifyListeners();

    final String url = Endpoints.baseUrl + Endpoints.checkQuality;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
print(url);
    try {
      final response = await DioHelper.postData(
        url: url,
        headers: {'Authorization': 'Bearer $token'},
        data: FormData.fromMap({
          'file': await MultipartFile.fromFile(video.path, filename: "video.mp4"),
        }),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        print(data);

        if (data is Map) {
          if (data['data'] is List) {
            _data = (data['data'] as List)
                .map((item) => QualityData.fromJson(item))
                .toList();
          }
          else if (data['status'] != null && data['results'] != null) {
            _data = [QualityData.fromJson(response.data)];
          }
        }

    } else {
        _errorMessage = 'Failed to check quality (Error ${response.statusCode})';
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
    _data = [];
    notifyListeners();
  }
}
