import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MH-Mobile"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // شبكتين
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            // إدارة الكروت
            _buildMenuCard(
              context,
              icon: Icons.credit_card,
              text: "إدارة الكروت",
              route: '/user_manager',
            ),

            // الطباعة
            _buildMenuCard(
              context,
              icon: Icons.print,
              text: "الطباعة",
              route: '/printing',
            ),

            // الإعدادات
            _buildMenuCard(
              context,
              icon: Icons.settings,
              text: "الإعدادات",
              route: '/profiles',
            ),

            // الاشتراك اليدوي
            _buildMenuCard(
              context,
              icon: Icons.note_add,
              text: "الاشتراك اليدوي",
              route: '/sales_user_manager',
            ),

            // الإيجار
            _buildMenuCard(
              context,
              icon: Icons.people,
              text: "الإيجار",
              route: '/sales_hotspot',
            ),

            // الحمل
            _buildMenuCard(
              context,
              icon: Icons.cloud_upload,
              text: "الحمل",
              route: '/expired_cards',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context,
      {required IconData icon, required String text, required String route}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.indigo),
              const SizedBox(height: 10),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}