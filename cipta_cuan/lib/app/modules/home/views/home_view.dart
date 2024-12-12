import 'package:cipta_cuan/app/modules/category/controllers/category_controller.dart';
import 'package:cipta_cuan/app/modules/profil/controllers/profil_controller.dart';
import 'package:cipta_cuan/app/modules/scheduling/views/scheduling_view.dart';
import 'package:cipta_cuan/models/myUser/myuser_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../profil/views/profil_view.dart';
import '../../category/views/category_view.dart';
import '../controllers/home_controller.dart';
import '../widget/home_widget.dart';

class HomeView extends StatefulWidget {
  final MyUser? myUser;
  const HomeView({super.key, required this.myUser});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.find<HomeController>();
  int _currentIndex = 0;
  late MyUser? myUser;
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => ProfilController());
    Get.lazyPut(() => CategoryController());
    myUser = widget.myUser;
    _children = [
      HomeWidget(), 
      SchedulingView(myUser: myUser), 
       CategoryView(), 
      ProfilView(), 
    ];
  }

  void onBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    myUser = widget.myUser;
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onBarTapped,
        currentIndex: _currentIndex,
        showUnselectedLabels: true,
        enableFeedback: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.transparent,
        unselectedItemColor: const Color(0xFF7B78AA),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        backgroundColor: const Color(0xFF141231),
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
            const SizedBox(height: 5),
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
          color: Colors.white, 
        ),
      ),
    );
  }
}
