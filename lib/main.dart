import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'di/app_module.dart';
import 'view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter MVVM Arch',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen('Flutter MVVM Arch'),
    );
  }
}
