import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:system_altruism_assignment/constants/api_constants.dart';
import 'package:system_altruism_assignment/models/image_model.dart';

class ApiServiceProvider extends ChangeNotifier {
  final List<ImageModel> _images = [];
  int _currentIndex = 0;
  Timer? _timer;

  List<ImageModel> get images => _images;
  int get currentIndex => _currentIndex;
  Timer? get timer => _timer;

  fetchImages() async {
    try {
      var res = await http
          .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.productsUrl));
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        List<dynamic> data = resBody['data']['data'];
        for (int i = 0; i < data.length; i++) {
          // print(i);
          var image = ImageModel.fromJson(data[i]);
          _images.add(image);
          print(data[i]);
        }
        startTimer();
        notifyListeners();
        // print(_images);
      } else {
        print("Something went wrong!");
      }
    } catch (e) {
      print("Exception occured $e");
    }
  }

  void startTimer() {
    // Timer to show items every 2 seconds
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _currentIndex++;
      notifyListeners();
      // Stop the timer when all items are shown
      if (_currentIndex >= _images.length) {
        timer.cancel();
      }
    });
  }
}
