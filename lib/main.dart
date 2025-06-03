import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tubes/pages/history_page.dart';
import 'package:tubes/pages/home_page.dart';
import 'package:tubes/pages/scanner_page.dart';
import 'package:tubes/pages/setting_page.dart';
import 'package:tubes/screen/splas_screen.dart';
import 'package:tubes/pages/penyakit_page.dart';
import 'package:tubes/widgets/custom_bottom_nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('id')],
      path: 'assets/translations',
      fallbackLocale: const Locale('id'),
      child: const LeafyPedia(),
    ),
  );
}

class LeafyPedia extends StatelessWidget {
  const LeafyPedia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RempahScan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      home: SplashScreen(),
      routes: {
        '/nav': (context) => const CustomBottomNav(),
        '/beranda': (context) => const HomePage(),
        '/scanner': (context) => const ScannerPage(),
        '/pengaturan': (context) => const SettingPage(),
        '/riwayat': (context) => const HistoryPage(),
        '/penyakit': (context) => const PenyakitPage(),
      },
    );
  }
}
