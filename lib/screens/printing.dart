
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class PrintingScreen extends StatefulWidget {
  const PrintingScreen({super.key});

  @override
  State<PrintingScreen> createState() => _PrintingScreenState();
}

class _PrintingScreenState extends State<PrintingScreen> {
  final _titleCtrl = TextEditingController(text: 'MH-Mobile Vouchers');
  final _rowsCtrl = TextEditingController(text: '3');
  final _colsCtrl = TextEditingController(text: '2');
  final _cardsCtrl = TextEditingController(text: '6');

  Future<void> _generatePDF() async {
    final pdf = pw.Document();
    final rows = int.tryParse(_rowsCtrl.text) ?? 3;
    final cols = int.tryParse(_colsCtrl.text) ?? 2;
    final total = int.tryParse(_cardsCtrl.text) ?? 6;

    pdf.addPage(pw.MultiPage(
      build: (ctx) => [
        pw.Text(_titleCtrl.text, style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 8),
        pw.GridView(
          crossAxisCount: cols,
          childAspectRatio: 3.5,
          children: List.generate(total, (i) {
            final num = i + 1;
            final user = 'U%03d'.replaceFirst('%03d', num.toString().padLeft(3, '0'));
            final pass = 'P%03d'.replaceFirst('%03d', num.toString().padLeft(3, '0'));
            return pw.Container(
              padding: const pw.EdgeInsets.all(8),
              margin: const pw.EdgeInsets.all(4),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(width: 0.8),
                borderRadius: pw.BorderRadius.circular(6),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Voucher #$num', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 4),
                  pw.Text('User: $user'),
                  pw.Text('Pass: $pass'),
                  pw.SizedBox(height: 4),
                  pw.Text('Profile: default'),
                ],
              ),
            );
          }),
        ),
      ],
    ));

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/mh_vouchers.pdf');
    await file.writeAsBytes(await pdf.save());

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم الحفظ: ${file.path}')));
  }

  Future<void> _sharePDF() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/mh_vouchers.pdf');
    if (await file.exists()) {
      await Share.shareXFiles([XFile(file.path)], text: 'MH-Mobile Vouchers');
    } else {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ولّد PDF أولاً')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الطباعة / PDF')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(controller: _titleCtrl, decoration: const InputDecoration(labelText: 'عنوان الصفحة')),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: TextField(controller: _rowsCtrl, decoration: const InputDecoration(labelText: 'عدد الصفوف'))),
              const SizedBox(width: 8),
              Expanded(child: TextField(controller: _colsCtrl, decoration: const InputDecoration(labelText: 'عدد الأعمدة'))),
              const SizedBox(width: 8),
              Expanded(child: TextField(controller: _cardsCtrl, decoration: const InputDecoration(labelText: 'عدد الكروت'))),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              ElevatedButton(onPressed: _generatePDF, child: const Text('توليد PDF')),
              const SizedBox(width: 8),
              OutlinedButton(onPressed: _sharePDF, child: const Text('مشاركة (واتساب/بلوتوث)')),
              const SizedBox(width: 8),
              OutlinedButton(onPressed: () { Printing.layoutPdf(onLayout: (_) async => (await getApplicationDocumentsDirectory()).path.codeUnits); }, child: const Text('طباعة مباشرة')),
            ]),
            const SizedBox(height: 8),
            const Text('يتم حفظ الملف داخل مجلد التطبيق (Documents).'),
          ],
        ),
      ),
    );
  }
}
