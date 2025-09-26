
import 'package:flutter/material.dart';

class ExpiredCardsScreen extends StatelessWidget {
  const ExpiredCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الكروت المنتهية')),
      body: const Padding(
        padding: EdgeInsets.all(12),
        child: Text('سيضاف زر تنظيف تلقائي (حسب الوقت/الصلاحية/التحميل) عبر الباكند.'),
      ),
    );
  }
}
