
import 'package:flutter/material.dart';
import '../services.api.dart';

class UserManagerScreen extends StatefulWidget {
  const UserManagerScreen({super.key});

  @override
  State<UserManagerScreen> createState() => _UserManagerScreenState();
}

class _UserManagerScreenState extends State<UserManagerScreen> {
  final _api = const ApiClient(baseUrl: 'https://YOUR-CODESPACE-URL', token: 'YOUR_TOKEN');
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _sharedCtrl = TextEditingController(text: '1');
  final _customerCtrl = TextEditingController(text: 'admin');
  final _profileCtrl = TextEditingController();

  Future<void> _create() async {
    if (_userCtrl.text.isEmpty || _passCtrl.text.isEmpty) return;
    try {
      await _api.umCreateUser(
        _userCtrl.text.trim(),
        _passCtrl.text.trim(),
        sharedUsers: int.tryParse(_sharedCtrl.text) ?? 1,
        customer: _customerCtrl.text.trim().isEmpty ? 'admin' : _customerCtrl.text.trim(),
        profile: _profileCtrl.text.trim().isEmpty ? null : _profileCtrl.text.trim(),
      );
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم الإنشاء في User Manager')));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('فشل: $e')));
    }
  }

  Future<void> _delete() async {
    if (_userCtrl.text.isEmpty) return;
    try {
      await _api.umDeleteUser(_userCtrl.text.trim());
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم الحذف')));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('فشل: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة الكروت – User Manager')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(children: [
              Expanded(child: TextField(controller: _userCtrl, decoration: const InputDecoration(labelText: 'اسم المستخدم'))),
              const SizedBox(width: 8),
              Expanded(child: TextField(controller: _passCtrl, decoration: const InputDecoration(labelText: 'كلمة المرور'))),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: TextField(controller: _sharedCtrl, decoration: const InputDecoration(labelText: 'Shared users'))),
              const SizedBox(width: 8),
              Expanded(child: TextField(controller: _customerCtrl, decoration: const InputDecoration(labelText: 'Customer (admin)'))),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: TextField(controller: _profileCtrl, decoration: const InputDecoration(labelText: 'Profile (اختياري)'))),
              const SizedBox(width: 8),
              ElevatedButton(onPressed: _create, child: const Text('إنشاء')),
              const SizedBox(width: 8),
              OutlinedButton(onPressed: _delete, child: const Text('حذف')),
            ]),
            const SizedBox(height: 12),
            const Text('ملاحظة: عرض المبيعات/الأرشيف سيتم ربطه مع قاعدة بيانات في الباكند.'),
          ],
        ),
      ),
    );
  }
}
