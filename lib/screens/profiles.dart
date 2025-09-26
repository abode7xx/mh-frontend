
import 'package:flutter/material.dart';

class ProfilesScreen extends StatelessWidget {
  const ProfilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profiles (فئات الكروت)')),
      body: const Padding(
        padding: EdgeInsets.all(12),
        child: Text('الملفّات/البروفايلات تُدار من الراوتر، سنعرضها لاحقًا من واجهة الباكند.'),
      ),
    );
  }
}
