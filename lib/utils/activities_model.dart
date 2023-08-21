import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ActivitiesModel extends ChangeNotifier {
  final Map<String, dynamic> _activities = {};
  Map<String, dynamic> get activities => _activities;

  Future<void> addActivity(Map<String, dynamic> activity) async {
    _activities[activity['key']] = activity;
    notifyListeners();
  }

  void removeActivity(activity) {
    _activities.remove(activity);
    notifyListeners();
  }
}

const List<String> typeList = [
  '',
  'education',
  'recreational',
  'social',
  'diy',
  'charity',
  'cooking',
  'relaxation',
  'music',
  'busywork'
];

class BoredApi {
  Future<Map<String, dynamic>> getActivity(
      {String type = '', String participants = ''}) async {const baseUrl = 'https://www.boredapi.com/api/activity/';

    final String url;

    url = '$baseUrl?type=$type';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load activity');
    }
  }
}
