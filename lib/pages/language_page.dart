import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('bahasa'.tr(), style: const TextStyle(color: Colors.black)),
      ),
      body: ListView(
        children: const [
          LanguageItem(label: 'Indonesia', locale: Locale('id')),
          LanguageItem(label: 'English', locale: Locale('en')),
        ],
      ),
    );
  }
}

class LanguageItem extends StatelessWidget {
  final String label;
  final Locale locale;

  const LanguageItem({super.key, required this.label, required this.locale});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(label),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        _showConfirmationDialog(context);
      },
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('konfirmasi'.tr()),
            content: Text('yakin_ubah_bahasa'.tr()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('batal'.tr()),
              ),
              TextButton(
                onPressed: () async {
                  await context.setLocale(locale);
                  Navigator.pop(context); // ✅ hanya menutup dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('berhasil_diubah'.tr())),
                  );
                },
                child: Text('ya'.tr()),
              ),
            ],
          ),
    );
  }
}
