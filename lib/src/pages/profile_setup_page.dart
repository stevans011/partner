import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/src/pages/dashboard_page.dart';
import 'package:partner/src/providers/auth_provider.dart';
import 'package:partner/src/widgets/common_widgets.dart';
import 'package:partner/src/widgets/custom_button.dart';
import 'package:partner/src/widgets/custom_input.dart';
import 'package:provider/provider.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AuthProvider>().addListener(() {
      final authProvider = context.read<AuthProvider>();
      if (authProvider.profileSetupLoading) {
        EasyLoading.show(status: "Loading...");
      } else {
        EasyLoading.dismiss();
      }
      if (authProvider.profileSetupSuccess) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const DashboardPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeColor.backGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppThemeColor.darkBlueColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              formSpacer(height: 24),
              CustomInput(
                controller: _usernameCtrl,
                title: "Username",
                hint: "username",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Username is Required";
                  }
                  return null;
                },
              ),
              formSpacer(),
              CustomInput(
                controller: _nameCtrl,
                title: "Name",
                hint: "Name",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Name is Required";
                  }
                  return null;
                },
              ),
              formSpacer(),
              CustomInput(
                controller: _dobCtrl,
                title: "Date Of Birth",
                hint: "YYYY-MM-Dd",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Dob is Required";
                  }
                  return null;
                },
              ),
              formSpacer(height: 24),
              CustomButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthProvider>().updateProfileDetail(
                        name: _nameCtrl.text,
                        username: _usernameCtrl.text,
                        dob: _dobCtrl.text);
                  }
                },
                title: "Save".toUpperCase(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
