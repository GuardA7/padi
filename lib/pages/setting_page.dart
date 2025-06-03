import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';
import 'language_page.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F9),
      appBar: AppBar(
        title: Text(
          'pengaturan'.tr(),
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('bahasa'.tr()),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LanguagePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
