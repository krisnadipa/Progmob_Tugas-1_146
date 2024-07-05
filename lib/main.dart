import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/login_page.dart';
import 'package:my_app/signup_page.dart'; // Import LoginPage dari login_page.dart
import 'package:my_app/home_page.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PROGMOB 1',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login', // Tentukan rute awal sebagai '/login'
      routes: {
        '/login': (context) => LoginPage(), // Tambahkan rute untuk LoginPage
        '/signup': (context) => SignUpPage(), // Tambahkan rute untuk SignUpPage
        '/home': (context) => HomePage(), // Tambahkan rute untuk SignUpPage
      },
    );
  }
}
