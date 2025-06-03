import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<HistoryItemData> historyItems = [
    HistoryItemData(label: 'scan_blast', date: '10 Mei 2025'),
    HistoryItemData(label: 'scan_turgo', date: '8 Mei 2025'),
    HistoryItemData(label: 'scan_bercak', date: '7 Mei 2025'),
  ];

  void _removeItem(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('hapus_riwayat'.tr()),
        content: Text('konfirmasi_hapus'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('batal'.tr()),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                historyItems.removeAt(index);
              });
              Navigator.pop(ctx);
            },
            child: Text(
              'hapus'.tr(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'riwayat'.tr(),
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: historyItems.length,
        itemBuilder: (context, index) {
          final item = historyItems[index];
          return GestureDetector(
            onLongPress: () => _removeItem(index),
            child: HistoryItem(label: item.label.tr(), date: item.date),
          );
        },
      ),
    );
  }
}

class HistoryItemData {
  final String label;
  final String date;

  HistoryItemData({required this.label, required this.date});
}

class HistoryItem extends StatelessWidget {
  final String label;
  final String date;

  const HistoryItem({super.key, required this.label, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.history, color: Colors.blue),
        title: Text(label),
        subtitle: Text(date),
        onTap: () {
          // Bisa arahkan ke detail jika perlu
        },
      ),
    );
  }
}
