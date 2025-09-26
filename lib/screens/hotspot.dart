
import 'package:flutter/material.dart';
import '../services.api.dart';

class HotspotScreen extends StatefulWidget {
  const HotspotScreen({super.key});

  @override
  State<HotspotScreen> createState() => _HotspotScreenState();
}

class _HotspotScreenState extends State<HotspotScreen> {
  final _api = const ApiClient(baseUrl: 'https://YOUR-CODESPACE-URL', token: 'YOUR_TOKEN');
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _profileCtrl = TextEditingController(text: 'default');
  List<dynamic> _active = [];
  List<dynamic> _hosts = [];
  bool _busy = false;

  Future<void> _load() async {
    setState(() => _busy = true);
    try {
      final a = await _api.hsActive();
      final h = await _api.hsHosts();
      setState(() { _active = a; _hosts = h; });
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطأ: $e')));
    } finally {
      setState(() => _busy = false);
    }
  }

  Future<void> _create() async {
    if (_userCtrl.text.isEmpty || _passCtrl.text.isEmpty) return;
    setState(() => _busy = true);
    try {
      await _api.hsCreateUser(_userCtrl.text.trim(), _passCtrl.text.trim(), profile: _profileCtrl.text.trim(), comment: 'via MH-Mobile');
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم الإنشاء')));
      await _load();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('فشل الإنشاء: $e')));
    } finally {
      setState(() => _busy = false);
    }
  }

  Future<void> _delete(String name) async {
    setState(() => _busy = true);
    try {
      await _api.hsDeleteUser(name);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم الحذف')));
      await _load();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('فشل الحذف: $e')));
    } finally {
      setState(() => _busy = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة الكروت – Hotspot')),
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
              Expanded(child: TextField(controller: _profileCtrl, decoration: const InputDecoration(labelText: 'Profile'))),
              const SizedBox(width: 8),
              ElevatedButton(onPressed: _busy ? null : _create, child: const Text('إنشاء كرت')),
              const SizedBox(width: 8),
              OutlinedButton(onPressed: _busy ? null : _load, child: const Text('تحديث')),
            ]),
            const SizedBox(height: 12),
            if (_busy) const LinearProgressIndicator(),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  const Text('المتصلون الآن:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ..._active.map((e) => ListTile(
                    leading: const Icon(Icons.wifi),
                    title: Text(e['user'] ?? e['name'] ?? '—'),
                    subtitle: Text('address: ${e.get('address') if false else (e['address'] ?? '-') }'),
                    trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () {
                      final name = e['user'] ?? e['name'];
                      if (name != null) _delete(name);
                    }),
                  )),
                  const Divider(),
                  const Text('الأجهزة:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ..._hosts.map((e) => ListTile(
                    leading: const Icon(Icons.devices_other),
                    title: Text(e['host-name'] ?? e['mac-address'] ?? '—'),
                    subtitle: Text('IP: ${e['address'] ?? '-'}'),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
