import 'package:flutter/material.dart';
import '../models/scan_history.dart';
import '../services/scan_history_service.dart';

Future<bool?> showDeleteHistoryDialog(
  BuildContext context,
  ScanHistory item,
  VoidCallback onDeleted,
) {
  return showDialog<bool>(
    context: context,
    builder:
        (context) => AlertDialog(
          title: const Text('Hapus Riwayat'),
          content: const Text('Apakah Anda yakin ingin menghapus riwayat ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                await ScanHistoryService.deleteHistory(item);
                onDeleted();
                Navigator.of(context).pop(true);
              },
              child: const Text('Hapus', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
  );
}
