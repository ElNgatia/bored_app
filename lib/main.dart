import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/color_schemes.g.dart';
import 'presentation/common_scaffold.dart';
import 'utils/activities_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) {
        return ActivitiesModel();
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adventure Quest',
      theme: ThemeData(
        useMaterial3: true,
         colorScheme: lightColorScheme),
      darkTheme: ThemeData(
        useMaterial3: true,
       colorScheme: darkColorScheme),
      home: const CommonScaffold(),
    );
  }
}
