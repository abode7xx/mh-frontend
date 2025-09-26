
import 'package:flutter/material.dart';

class SalesHotspotScreen extends StatelessWidget {
  const SalesHotspotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مبيعات – Hotspot')),
      body: const Center(child: Text('سيتم ربطها بقاعدة بيانات الباكند (جمع العمليات وعرض التقارير/الأرشيف).')),
    );
  }
}
