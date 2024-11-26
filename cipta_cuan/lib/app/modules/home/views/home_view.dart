import 'package:cipta_cuan/app/modules/profil/controllers/profil_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../profil/views/profil_view.dart';
import '../controllers/home_controller.dart';
import '../widget/home_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.find<HomeController>();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => ProfilController());
  }

  final List<Widget> _children = [
    const HomeWidget(),
    const HomeWidget(),
    const HomeWidget(),
    const ProfilView(),
  ];

  void onBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onBarTapped,
        currentIndex: _currentIndex,
        showUnselectedLabels: true,
        enableFeedback: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.transparent,
        unselectedItemColor: Color(0xFF7B78AA),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        backgroundColor: Color(0xFF141231),
        items: [
          _buildBottomNavItem(
            'assets/icons/menu_beranda.svg',
            'Beranda',
            0,
          ),
          _buildBottomNavItem(
            'assets/icons/menu_jadwal.svg',
            'Jadwal',
            1,
          ),
          _buildBottomNavItem(
            'assets/icons/menu_kategori.svg',
            'Kategori',
            2,
          ),
          _buildBottomNavItem(
            'assets/icons/menu_profil.svg',
            'Profil',
            3,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(
      String iconPath, String label, int index) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              colorFilter: _currentIndex == index
                  ? null
                  : const ColorFilter.mode(Color(0xFF7B78AA), BlendMode.srcIn),
            ),
            SizedBox(height: 5),
            _currentIndex == index
                ? _buildGradientText(label) // Label dengan gradien
                : Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF7B78AA),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
          ],
        ),
      ),
      label: '',
    );
  }

  Widget _buildGradientText(String text) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Color(0xFF0DA6C2),
          Color(0xFF0E39C6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white, // Warna ini tidak terlihat karena ShaderMask
        ),
      ),
    );
  }
}
