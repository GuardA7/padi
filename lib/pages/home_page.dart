import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tubes/dialog/delete.dart';
import '../services/scan_history_service.dart';
import '../models/scan_history.dart';
import '../widgets/history_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ScanHistory> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final data = await ScanHistoryService.loadHistory();
    setState(() {
      _history = data;
    });
  }

  Future<void> _deleteHistoryItem(ScanHistory item) async {
    // Panggil dialog konfirmasi dari file terpisah
    final confirm = await showConfirmDeleteDialog(context);
    if (confirm == true) {
      await ScanHistoryService.deleteHistory(item);
      await _loadHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'home_title'.tr(),
          style: const TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pushNamed('/scanner');
                  if (result == true) {
                    _loadHistory();
                  }
                },
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.qr_code_scanner, color: Colors.white),
                      const SizedBox(width: 16),
                      Text(
                        'scan_penyakit_padi'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'scan_terakhir'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              HistoryList(history: _history, onDelete: _deleteHistoryItem),
            ],
          ),
        ),
      ),
    );
  }
}
