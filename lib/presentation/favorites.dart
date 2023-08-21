import 'package:bored_app/utils/activities_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Consumer<ActivitiesModel>(builder: (builder, activitiesModel, child) {
        final activities = activitiesModel.activities;

        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final activity = activities.values.elementAt(index);
            return Container(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                tileColor: Colors.grey[300],
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
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    activitiesModel.removeActivity(activity['key']);
                  },
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 2);
          },
          itemCount: activities.length,
        );
      }),
    );
  }
}
