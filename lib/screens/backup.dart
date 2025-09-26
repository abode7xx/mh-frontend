
import 'package:flutter/material.dart';

class BackupScreen extends StatelessWidget {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('النسخ الاحتياطي')),
      body: const Padding(
        padding: EdgeInsets.all(12),
        child: Text('سنوفر زر إنشاء نسخة احتياطية لإعدادات السيرفر/اليوزر مانجر عبر الباكند.'),
      ),
    );
  }
}
