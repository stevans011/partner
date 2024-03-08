import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partner/Utils/Colors.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    this.controller,
    this.title,
    this.validator,
    this.hint,
    this.inputFormatters,
    this.inputType,
  });
  final TextEditingController? controller;
  final String? title;
  final String? Function(String?)? validator;
  final String? hint;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppThemeColor.pureBlackColor,
            ),
          ),
        ),
        Material(
          elevation: 10.0,
          shadowColor: Colors.grey.withOpacity(0.5),
          child: TextFormField(
            controller: controller,
            textAlign: TextAlign.left,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: inputType,
            inputFormatters: inputFormatters,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            style: const TextStyle(
              color: AppThemeColor.pureBlackColor,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              filled: true,
              isDense: true,
              fillColor: AppThemeColor.pureWhiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
