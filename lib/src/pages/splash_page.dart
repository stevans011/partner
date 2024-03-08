import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/src/pages/dashboard_page.dart';
import 'package:partner/src/pages/login_page.dart';
import 'package:partner/src/pages/profile_setup_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    _checkAuth();
  }

  // Check auth either user is login or not
  void _checkAuth() {
    /**
     * Splash screen should be visible around 2 seconds
     * 1. If user is authenticated, navigate to dashboard 
     * 2. If not authendicated, just navigate to login 
     */
    Future.delayed(const Duration(seconds: 2), () async {
      if (FirebaseAuth.instance.currentUser != null) {
        // Navigate to dashboard
        final query = await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get();
        if (query.data()!["username"] != "") {
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (_) => const DashboardPage()),
          );
        } else {
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (_) => const ProfileSetupPage()),
          );
        }
      } else {
        // Unauthenticated -> Navigate to login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: AppThemeColor.darkBlueColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'images/splashBackground.png',
              fit: BoxFit.cover,
            ),
            Image.asset('images/inAppIcon.png'),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 48,
              child: Align(
                  child: CircularProgressIndicator(
                color: AppThemeColor.pureWhiteColor,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
