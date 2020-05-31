import 'package:flutter/material.dart';
import 'package:adsandurl/Router/GenerateRoutClass.dart' as router;
import 'Router/GenerateRoutClass.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
      initialRoute: router.mainScreen,
      title: 'Ads and Url',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

