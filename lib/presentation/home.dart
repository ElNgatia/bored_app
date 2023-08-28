import 'dart:convert';

import 'package:adventure_quest/utils/activities_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final BoredApi _boredApi = BoredApi();
  Map<String, dynamic>? fetchedActivity;

  @override
  void initState() {
    super.initState();
    _getActivity();
  }

  Future<void> _getActivity() async {
    final newActivity = await _boredApi.getActivity();
    setState(() {
      fetchedActivity = newActivity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ActivitiesModel>(
        builder: (context, activitiesModel, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  width: double.infinity,
                  height: 300,
                  child: Card(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (fetchedActivity != null)
                        Column(
                          children: [
                            const Text(
                              'Activity',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Center(
                                child:
                                    Text(fetchedActivity!['activity'] ?? '')),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Type',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Text(fetchedActivity!['type'] ?? ''),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Participants',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Text(fetchedActivity!['participants']?.toString() ??
                                ''),
                          ],
                        ),
                      if (fetchedActivity == null)
                        const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(),
                        )
                    ],
                  )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final newActivity = await _boredApi.getActivity();
                        setState(() {
                          fetchedActivity = newActivity;
                        });
                      },
                      child: const Text(
                        'Get Activity',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (fetchedActivity != null) {
                            // add to favorites
                            activitiesModel
                                .addActivity(Map.from(fetchedActivity!));

                            // save to local storage
                            SharedPreferences.getInstance()
                                .then((SharedPreferences prefs) {
                              final favorites =
                                  prefs.getStringList('favorites') ?? [];
                              favorites.add(json.encode(fetchedActivity));
                              prefs.setStringList('favorites', favorites);
                            });

                            Fluttertoast.showToast(
                              msg: 'Added to favorites',
                              toastLength: Toast
                                  .LENGTH_SHORT, // Duration for how long the toast should be displayed
                              gravity: ToastGravity
                                  .BOTTOM, // Position of the toast on the screen
                              backgroundColor: Colors
                                  .grey[600], // Background color of the toast
                              textColor: Colors.white,
                            );
                          }
                        },
                        child: const Text('Add to Favorites')),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
