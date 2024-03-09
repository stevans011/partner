import 'package:flutter/material.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/src/models/action_state.dart';
import 'package:partner/src/models/partner.dart';
import 'package:partner/src/providers/connect_partner_provider.dart';
import 'package:partner/src/widgets/common_widgets.dart';
import 'package:partner/src/widgets/custom_button.dart';
import 'package:partner/src/widgets/custom_phone_input.dart';
import 'package:provider/provider.dart';

class ConnectPartnerPage extends StatefulWidget {
  const ConnectPartnerPage({super.key});

  @override
  State<ConnectPartnerPage> createState() => _ConnectPartnerPageState();
}

class _ConnectPartnerPageState extends State<ConnectPartnerPage> {
  final TextEditingController _phoneCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final connectProvider = context.watch<ConnectPartnerProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search Partner",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          children: [
            const Text(
              "Enter the phone number",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            formSpacer(),
            CustomPhoneInput(
              phoneCtrl: _phoneCtrl,
              title: "",
            ),
            formSpacer(height: 24),
            CustomButton(
              isLoading: connectProvider.searchState.state.isLoading,
              height: 42,
              bgColor: AppThemeColor.darkBlueColor,
              radius: 0,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  connectProvider.searchPartner(_phoneCtrl.text);
                }
              },
              title: "Search",
            ),
            formSpacer(),
            _partnerCard(),
          ],
        ),
      ),
    );
  }

  Widget _partnerCard() {
    final connectProvider = context.watch<ConnectPartnerProvider>();
    if (connectProvider.searchState.state.isSuccess) {
      Partner partner = connectProvider.searchState.successData as Partner;
      ActionState requestState = connectProvider.sendRequestState;
      return Container(
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
            onTap: () {
              //Check connect request too
              if (!connectProvider.sendRequestState.state.isLoading &&
                  partner.connectRequest == null) {
                connectProvider.sendConnectRequest(partner.id);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: connectProvider.searchState.state.isLoading
                    ? AppThemeColor.grayColor
                    : AppThemeColor.darkBlueColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                requestState.state.isSuccess || partner.connectRequest != null
                    ? "Sent"
                    : "Send Invitation",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppThemeColor.pureWhiteColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
