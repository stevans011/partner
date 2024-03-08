import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/src/pages/otp_page.dart';
import 'package:partner/src/providers/auth_provider.dart';
import 'package:partner/src/widgets/common_widgets.dart';
import 'package:partner/src/widgets/custom_button.dart';
import 'package:partner/src/widgets/custom_phone_input.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AuthProvider>().addListener(() {
      final authProvider = context.read<AuthProvider>();
      if (authProvider.verifyPhoneLoading) {
        EasyLoading.show(status: "Loading...");
      } else {
        EasyLoading.dismiss();
      }
      if (authProvider.verificationId != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const OtpPage()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeColor.backGroundColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Image.asset(
                'images/inAppIcon.png',
              ),
            ),
            Text(
              "Login".toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppThemeColor.darkBlueColor,
                fontSize: 41,
              ),
            ),
            formSpacer(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomPhoneInput(
                    phoneCtrl: _phoneCtrl,
                  ),
                  formSpacer(height: 24),
                  CustomButton(
                    title: "Login".toUpperCase(),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<AuthProvider>()
                            .verifyPhone(_phoneCtrl.text);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
