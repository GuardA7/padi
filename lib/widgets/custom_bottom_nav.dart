import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tubes/pages/home_page.dart';
import 'package:tubes/pages/penyakit_page.dart';
import 'package:tubes/pages/setting_page.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(
      initialIndex: 1, // index 1 untuk "beranda"
    );
  }

  List<Widget> _buildScreens() {
    return [const PenyakitPage(), const HomePage(), const SettingPage()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.book_online),
        title: tr('data_penyakit'),
        activeColorPrimary: const Color(0xFF4CAF50),
        activeColorSecondary: const Color(0xFF4CAF50),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: tr('beranda'),
        activeColorPrimary: const Color(0xFF4CAF50),
        activeColorSecondary: const Color(0xFF4CAF50),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: tr('pengaturan'),
        activeColorPrimary: const Color(0xFF4CAF50),
        activeColorSecondary: const Color(0xFF4CAF50),
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: false,
      stateManagement: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(16),
        colorBehindNavBar: Colors.white,
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }
}
