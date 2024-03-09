import 'package:flutter/material.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/src/pages/connect_partner_page.dart';
import 'package:partner/src/providers/connect_partner_provider.dart';
import 'package:partner/src/widgets/common_widgets.dart';
import 'package:partner/src/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
          Row(
            children: [
              Expanded(
                child: _infoCard(
                  title: "Partner Connected",
                  value: "getrajan",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _infoCard(
                  title: "No. of Quiz Finished",
                  value: "0",
                ),
              )
            ],
          ),
          formSpacer(height: 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: CustomButton(
              bgColor: AppThemeColor.pureBlackColor,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) => ConnectPartnerProvider(),
                      child: const ConnectPartnerPage(),
                    ),
                  ),
                );
              },
              title: "Connect with partner",
              radius: 0,
            ),
          ),
          formSpacer(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: CustomButton(
              bgColor: AppThemeColor.darkBlueColor,
              radius: 0,
              onTap: () {},
              title: "Start Quiz",
            ),
          )
        ],
      ),
    );
  }

  Widget _infoCard({required String title, required String value}) {
    return Container(
      decoration: BoxDecoration(
        color: AppThemeColor.pureWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 2,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        child: Column(
          children: [
            FittedBox(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppThemeColor.darkBlueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
