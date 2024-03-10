import 'package:flutter/material.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/src/models/partner.dart';

class MyPartnersPage extends StatefulWidget {
  const MyPartnersPage({super.key});

  @override
  State<MyPartnersPage> createState() => _MyPartnersPageState();
}

class _MyPartnersPageState extends State<MyPartnersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Partners"),
      ),
      body: ListView(
        children: List.generate(
          5,
          (index) => _partnerCard(
            const Partner(
              id: "id",
              dob: "abc",
              username: "getrajan",
              phone: "0980900",
            ),
          ),
        ),
      ),
    );
  }

  Widget _partnerCard(Partner partner) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8, right: 24),
      decoration: BoxDecoration(
        color: AppThemeColor.pureWhiteColor,
        boxShadow: [
          BoxShadow(
            color: AppThemeColor.grayColor.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppThemeColor.darkBlueColor,
          ),
          child: const Icon(
            Icons.person,
            color: AppThemeColor.pureWhiteColor,
            size: 32,
          ),
        ),
        title: Text(partner.username),
        subtitle: Text(partner.phone),
        trailing: GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: AppThemeColor.grayColor.withOpacity(0.2),
            ),
            child: const Text(
              "Disconnect",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
