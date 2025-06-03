import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/custom_bottom_nav.dart';
import 'detail_penyakit_page.dart';

class PenyakitPage extends StatelessWidget {
  const PenyakitPage({super.key});

  Future<Map<String, dynamic>> loadPenyakitData() async {
    final String response = await rootBundle.loadString(
      'assets/data/datapenyakit.json',
    );
    final data = json.decode(response);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F9),
      appBar: AppBar(
        title: const Text("Data Penyakit"),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: loadPenyakitData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }

          final penyakitData = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: penyakitData.length,
            itemBuilder: (context, index) {
              String key = penyakitData.keys.elementAt(index);
              var item = penyakitData[key];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => DetailPenyakitPage(
                            nama: item['nama'] ?? '-',
                            deskripsi: item['deskripsi'] ?? '-',
                            gambar: item['gambar'] ?? '',
                          ),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        child: Image.asset(
                          item['gambar'] ?? '',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item['nama'] ?? '-',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
