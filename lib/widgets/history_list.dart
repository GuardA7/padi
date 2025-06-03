import 'dart:io';
import 'package:flutter/material.dart';
import '../models/scan_history.dart';

typedef OnDeleteCallback = void Function(ScanHistory item);

class HistoryList extends StatelessWidget {
  final List<ScanHistory> history;
  final OnDeleteCallback onDelete;

  const HistoryList({Key? key, required this.history, required this.onDelete})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return const Center(child: Text('Tidak ada riwayat pemindaian.'));
    }

    return Column(
      children:
          history.map((item) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Image.file(
                    File(item.imagePath),
                    height: 48,
                    width: 36,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.disease,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          item.date,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => onDelete(item),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
