import 'package:flutter/material.dart';
import 'api.dart';
import 'login_page.dart';
import 'products_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ApiClient api = ApiClient();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whitelabel E-commerce',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      routes: {
        '/': (ctx) => LoginPage(api: api),
        '/products': (ctx) => ProductsPage(api: api),
      },
    );
  }
}
