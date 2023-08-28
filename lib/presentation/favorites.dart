import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/activities_model.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Map<String, dynamic>> favorites = [];

  @override
  void initState() {
    super.initState();
    _getFavorites();
  }

Future<void> _getFavorites() async {
  final prefs = await SharedPreferences.getInstance();
  final favoritesStringList = prefs.getStringList('favorites') ?? [];

  setState(() {
    favorites = favoritesStringList.map<Map<String, dynamic>>((favoritesString) {
      return Map<String, dynamic>.from(json.decode(favoritesString));
    }).toList();
  });
}

  Future<void> _updateFavorites(
      List<Map<String, dynamic>> updatedFavorite) async {
    final prefs = await SharedPreferences.getInstance();
    final updatedFavoriteJsonList = updatedFavorite.map((activity) {
      return json.encode(activity);
    }).toList();

    await prefs.setStringList('favorites', updatedFavoriteJsonList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Consumer<ActivitiesModel>(builder: (builder, activitiesModel, child) {
        final activities = activitiesModel.activities;

        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final activity = favorites[index];
            return Container(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                // tileColor: ,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text(
                  activity['activity'] ?? '',
                ),
                subtitle: Text(
                  activity['type'] ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // IconButton(
                    //   onPressed: () {
                    //
                    //   },
                    //   icon: Icon(Icons.done),
                    // ),
                    IconButton(
                      icon: const Icon(Icons.cancel_outlined),
                      onPressed: () {
                        activitiesModel.removeActivity(activity['key']);

                        setState(() {
                          favorites.remove(activity);
                        });
                        _updateFavorites(favorites);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 2);
          },
          itemCount: favorites.length,
        );
      }),
    );
  }
}
