import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/scan_history.dart';

class ScanHistoryService {
  static const _key = 'scan_history';

  static Future<void> saveHistory(ScanHistory history) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    data.add(json.encode(history.toJson()));
    await prefs.setStringList(_key, data);
  }

  static Future<List<ScanHistory>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data
        .map((e) => ScanHistory.fromJson(json.decode(e)))
        .toList()
        .reversed
        .toList();
  }

  static Future<void> deleteHistory(ScanHistory item) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];

    // Filter data, hapus item yang cocok dengan parameter
    final filteredData =
        data.where((e) {
          final jsonMap = json.decode(e);
          final historyItem = ScanHistory.fromJson(jsonMap);
          // Bandingkan dengan cara unik, misal berdasarkan imagePath dan date
          return !(historyItem.imagePath == item.imagePath &&
              historyItem.date == item.date);
        }).toList();

    await prefs.setStringList(_key, filteredData);
  }
}
