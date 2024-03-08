import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partner/Utils/Colors.dart';

class CustomPhoneInput extends StatelessWidget {
  const CustomPhoneInput({
    super.key,
    this.phoneCtrl,
  });
  final TextEditingController? phoneCtrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Phone Number",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppThemeColor.pureBlackColor,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Material(
                elevation: 10.0,
                shadowColor: Colors.grey.withOpacity(0.5),
                child: TextFormField(
                  textAlign: TextAlign.right,
                  readOnly: true,
                  initialValue: "+61",
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    isDense: true,
                    fillColor: AppThemeColor.pureWhiteColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 3,
              child: Material(
                elevation: 10.0,
                shadowColor: Colors.grey.withOpacity(0.5),
                child: TextFormField(
                  controller: phoneCtrl,
                  textAlign: TextAlign.left,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Phone number is requried";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  style: const TextStyle(
                    color: AppThemeColor.pureBlackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    hintText: "413535656",
                    border: InputBorder.none,
                    filled: true,
                    isDense: true,
                    fillColor: AppThemeColor.pureWhiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
