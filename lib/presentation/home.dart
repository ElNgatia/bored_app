import 'package:bored_app/utils/activities_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>  {
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
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  width: double.infinity,
                  height: 250,
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
                                Text(fetchedActivity!['activity'] ?? ''),
                                const Text(
                                  'Type',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(fetchedActivity!['type'] ?? ''),
                                const Text(
                                  'Participants',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(fetchedActivity!['participants']
                                        ?.toString() ??
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
                            activitiesModel
                                .addActivity(Map.from(fetchedActivity!));
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
