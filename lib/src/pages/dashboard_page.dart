import 'package:flutter/material.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/src/pages/account_page.dart';
import 'package:partner/src/pages/connect_page.dart';
import 'package:partner/src/pages/home_page.dart';
import 'package:partner/src/providers/bottom_nav_provider.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeColor.backGroundColor,
      body: Stack(
        children: [
          _bodyView(),
          _bottomNavBar(),
        ],
      ),
    );
  }

  Widget _bodyView() {
    return Positioned.fill(
      child: IndexedStack(
        index: context.read<BottomNavProvider>().itemIndex,
        children: [
          const HomePage(),
          const ConnectPage(),
          Container(
            color: Colors.purple,
            alignment: Alignment.center,
            child: const Text("History"),
          ),
          const AccountPage(),
        ],
      ),
    );
  }

  Widget _bottomNavBar() {
    final bottomNavProvider = context.watch<BottomNavProvider>();
    return Positioned(
      bottom: 12,
      left: 18,
      right: 18,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppThemeColor.pureWhiteColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4,
              spreadRadius: 2,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _bottomBarItem(
              title: "Home",
              icon: Icons.home,
              isCurrent: bottomNavProvider.itemIndex == 0,
              onTap: () {
                bottomNavProvider.changeItem(0);
              },
            ),
            _bottomBarItem(
              title: "Connect",
              icon: Icons.favorite,
              isCurrent: bottomNavProvider.itemIndex == 1,
              onTap: () {
                bottomNavProvider.changeItem(1);
              },
            ),
            _bottomBarItem(
              title: "History",
              icon: Icons.history,
              isCurrent: bottomNavProvider.itemIndex == 2,
              onTap: () {
                bottomNavProvider.changeItem(2);
              },
            ),
            _bottomBarItem(
              title: "Account",
              icon: Icons.person,
              isCurrent: bottomNavProvider.itemIndex == 3,
              onTap: () {
                bottomNavProvider.changeItem(3);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomBarItem({
    required String title,
    required IconData icon,
    bool isCurrent = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isCurrent
                ? AppThemeColor.darkBlueColor
                : AppThemeColor.pureBlackColor,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isCurrent
                  ? AppThemeColor.darkBlueColor
                  : AppThemeColor.pureBlackColor,
            ),
          ),
        ],
      ),
    );
  }
}
