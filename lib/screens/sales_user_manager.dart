
import 'package:flutter/material.dart';

class SalesUserManagerScreen extends StatelessWidget {
  const SalesUserManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مبيعات – User Manager')),
      body: const Center(child: Text('سيتم ربطها بقاعدة بيانات الباكند (جمع العمليات وعرض التقارير/الأرشيف).')),
    );
  }
}
