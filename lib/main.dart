import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/about_screen.dart';

const kPrimary = Color(0xFF3F51B5);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MH-Mobile',
      theme: ThemeData(
        colorSchemeSeed: kPrimary,
        useMaterial3: true,

        // 👇 هنا ضمان أن النصوص كلها باللون الأسود
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          bodySmall: TextStyle(color: Colors.black),
          titleLarge: TextStyle(color: Colors.black),
          titleMedium: TextStyle(color: Colors.black),
          titleSmall: TextStyle(color: Colors.black),
        ),

        // 👇 لضبط النصوص داخل الأزرار
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(Colors.white), // زر تسجيل
            textStyle: WidgetStateProperty.all(
              TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(Colors.black), // زر عرض الكود
            textStyle: WidgetStateProperty.all(
              TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(Colors.black), // الروابط
            textStyle: WidgetStateProperty.all(
              TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),

      // 👇 البداية تكون صفحة تسجيل الدخول
      home: const LoginScreen(),

      routes: {
        '/home': (c) => const HomeScreen(),
        '/about': (c) => const AboutScreen(),
        '/login': (c) => const LoginScreen(),
      },
    );
  }
}