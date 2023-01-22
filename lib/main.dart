import 'package:file_tracking_system/login/numberVerfication.dart';
import 'package:file_tracking_system/pages/totalFile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color PrimaryColor = Color.fromARGB(255, 84, 22, 208);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color.fromARGB(255, 84, 22, 208)),
      routes: {
        "/": (context) => TotalFile(),
        "/": (context) => const NumberVerfication(),
      },
    );
  }
}
