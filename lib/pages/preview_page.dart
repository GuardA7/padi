import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tubes/pages/home_page.dart';
import 'package:tubes/services/api_service.dart';
import 'package:tubes/models/scan_history.dart';
import 'package:tubes/services/scan_history_service.dart';
import 'package:tubes/widgets/custom_bottom_nav.dart';

class PreviewPage extends StatefulWidget {
  final String imagePath;

  const PreviewPage({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  String? diseaseName;
  String? diseaseInfo;
  double? confidence;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _analyzeImage(File(widget.imagePath));
  }

  Future<void> _analyzeImage(File imageFile) async {
    try {
      final result = await ApiService.predictDisease(imageFile);

      // Simpan ke history
      await ScanHistoryService.saveHistory(
        ScanHistory(
          disease: result.prediction,
          confidence: result.confidence,
          date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          imagePath: imageFile.path,
        ),
      );

      setState(() {
        diseaseName = result.prediction;
        diseaseInfo = result.info;
        confidence = result.confidence;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        diseaseName = 'Tidak Diketahui';
        diseaseInfo = 'Gagal memuat informasi penyakit.\nError: $e';
        confidence = null;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final File imageFile = File(widget.imagePath);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hasil Analisis',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFFFAF9F9),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        imageFile,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Penyakit Terdeteksi:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  diseaseName ?? 'Tidak diketahui',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4CAF50),
                                  ),
                                ),
                                if (confidence != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    'Tingkat keyakinan: ${(confidence! * 100).toStringAsFixed(2)}%',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 16),
                                const Text(
                                  'Informasi Penyakit:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  diseaseInfo ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CustomBottomNav(),
                          ),
                          (route) => false,
                        );
                      },
                      label: const Text(
                        'Selesai',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
