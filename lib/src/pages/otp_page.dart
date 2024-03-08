import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/src/pages/dashboard_page.dart';
import 'package:partner/src/pages/profile_setup_page.dart';
import 'package:partner/src/providers/auth_provider.dart';
import 'package:partner/src/widgets/common_widgets.dart';
import 'package:partner/src/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String otp = "";

  @override
  void initState() {
    super.initState();
    context.read<AuthProvider>().addListener(() {
      final authProvider = context.read<AuthProvider>();
      if (authProvider.isLoginLoading) {
        EasyLoading.show(status: "Loading...");
      } else {
        EasyLoading.dismiss();
        if (authProvider.userAlreadyExist) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const DashboardPage()),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const ProfileSetupPage()),
            (route) => false,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeColor.backGroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            formSpacer(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Image.asset('images/inAppIcon.png'),
            ),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: AppThemeColor.pureBlackColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(text: "Enter the "),
                  TextSpan(
                    text: "OTP",
                    style: TextStyle(
                      color: AppThemeColor.darkBlueColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            formSpacer(height: 24),
            OTPTextField(
              width: MediaQuery.of(context).size.width,
              length: 6,
              fieldWidth: MediaQuery.of(context).size.width / 8.3,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              hasError: otp.length != 6,
              onChanged: (value) {
                setState(() {
                  otp = value;
                });
              },
            ),
            formSpacer(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: CustomButton(
                height: 42,
                onTap: () {
                  if (otp.length == 6) {
                    context.read<AuthProvider>().login(otp);
                  }
                },
                title: "Verify".toUpperCase(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
