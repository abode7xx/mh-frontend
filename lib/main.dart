import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // يخفي الشريط الأحمر
      title: 'MH Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("مرحباً بك 👋"),
      ),
      body: const Center(
        child: Text(
          "التطبيق شغال بنجاح 🎉",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}