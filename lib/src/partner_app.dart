import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:partner/src/pages/splash_page.dart';
import 'package:partner/src/providers/auth_provider.dart';
import 'package:partner/src/providers/bottom_nav_provider.dart';
import 'package:provider/provider.dart';

class PartnerApp extends StatelessWidget {
  const PartnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
