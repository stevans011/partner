import 'package:flutter/material.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/src/pages/login_page.dart';
import 'package:partner/src/providers/auth_provider.dart';
import 'package:partner/src/providers/bottom_nav_provider.dart';
import 'package:partner/src/widgets/common_widgets.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.notifications),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ListView(
        padding:
            const EdgeInsets.only(bottom: 60, top: 12, left: 12, right: 12),
        children: [
          Align(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Image.asset(
                  'images/profile.png',
                  height: 80,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppThemeColor.pureBlackColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: const Icon(
                    Icons.edit_outlined,
                    color: AppThemeColor.pureWhiteColor,
                    size: 17,
                  ),
                ),
              ],
            ),
          ),
          formSpacer(height: 8),
          _info(),
          formSpacer(),
          _actionItem(title: "Edit Profile", icon: Icons.person),
          _actionItem(title: "Payment", icon: Icons.payments),
          _actionItem(title: "Help Center", icon: Icons.person_pin_outlined),
          _actionItem(title: "FAQ's", icon: Icons.help_outline),
          _actionItem(title: "Invite Friends", icon: Icons.people),
          _actionItem(
            title: "Logout",
            icon: Icons.logout,
            onTap: () {
              context.read<AuthProvider>().logout().then((value) {
                context.read<BottomNavProvider>().changeItem(0);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _info() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "getrajan",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppThemeColor.pureBlackColor,
          ),
        ),
        Text(
          "973432343545",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppThemeColor.grayColor,
          ),
        ),
      ],
    );
  }

  Widget _actionItem({
    required String title,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 18,
        color: AppThemeColor.pureBlackColor,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppThemeColor.pureBlackColor,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 18,
        color: AppThemeColor.pureBlackColor,
      ),
    );
  }
}
