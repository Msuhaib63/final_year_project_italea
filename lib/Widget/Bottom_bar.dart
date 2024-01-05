import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:final_year_project_italea/Constant/icons.dart';
import 'package:final_year_project_italea/Constant/saiz.dart';
import 'package:final_year_project_italea/Basic_Page/Belajar_page.dart';
import 'package:final_year_project_italea/Basic_Page/Dashboard_page.dart';
import 'package:final_year_project_italea/Basic_Page/Quran_page.dart';
import 'package:final_year_project_italea/Basic_Page/Quiz_page.dart';
import 'package:final_year_project_italea/Basic_Page/Profile_page.dart';

class WidgetBottomBar extends StatefulWidget {

  const WidgetBottomBar({Key? key}) : super(key: key);

  @override
  State<WidgetBottomBar> createState() => _WidgetBottomBarState();
}

class _WidgetBottomBarState extends State<WidgetBottomBar> {

  @override
  Widget build(BuildContext context) {

    List<Widget> _buildPage() {
      return [
        const Belajarpage(),
        const DashBoardPage(),
        const QuranPage(),
        const QuizPage(),
        const ProfilePage()
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Center(child: Image.asset(icBottomBelajar,height: kBottomNavigationBarItemSize,)),
          title: ("Belajar"),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.grey,
          //label: "Belajar",
        ),
        PersistentBottomNavBarItem(
          icon: Center(child: Image.asset(icBottomDashboard,height: kBottomNavigationBarItemSize,)),
          title: ("Dashboard"),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Center(child: Image.asset(icBottomQuran,height: kBottomNavigationBarItemSize,)),
          title: ("Quran"),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(icBottomQuiz,height: kBottomNavigationBarItemSize),
          title: ("Quiz"),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Center(child: Image.asset(icBottomProfile,height: kBottomNavigationBarItemSize,)),
          title: ("Profile"),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildPage(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true,// Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.

      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),

      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,

      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),

      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),

      navBarStyle: NavBarStyle.style9, // Choose the nav bar style with this property.
    );
  }
}