import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton(), title: const Text('حول التطبيق')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    Text('MH Frontend', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                    SizedBox(height: 8),
                    Text('نسخة تجريبية لواجهة Flutter مع تنقل بسيط بين الشاشات.'),
                    SizedBox(height: 14),
                    ListTile(
                      leading: Icon(Icons.build_outlined),
                      title: Text('Flutter 3 • Material Design 3'),
                    ),
                    ListTile(
                      leading: Icon(Icons.web_rounded),
                      title: Text('تعمل على الويب والموبايل (Android/iOS)'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}