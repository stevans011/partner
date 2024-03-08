import 'package:flutter/material.dart';
// Flutter Material package for widgets and UI components

import 'package:partner/Utils/Colors.dart';
// Custom utility file for application colors.
import 'package:partner/Utils/dimensions.dart';
// Custom utility file for dimesions colors.

class ForgetPasswordScreen extends StatefulWidget {
  // Defining a stateful widget ForgetPasswordScreen that extends StatefulWidget. The widget takes no required parameters.

  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
//   Defining the _ForgetPasswordScreenState class, which extends the State class for managing the state of the widget.
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  // Initialize _screenWidth and _screenHeight inside the build method

  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return Container(
        //Width and height of the container are set to _screenWidth and _screenHeight,
        width: _screenWidth,
        height: _screenHeight,
        //The container has a background color defined by AppThemeColor.backGroundColor.
        color: AppThemeColor.backGroundColor,
        padding: const EdgeInsets.all(20),
        child: Column(
          //mainAxisAlignment is set to MainAxisAlignment.spaceAround, which distributes the children evenly with equal space between them vertically.
          //crossAxisAlignment is set to CrossAxisAlignment.start, which aligns the children to the left horizontally.

          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //The first child of the column is an Image.asset, which displays an image with the path 'images/inAppIcon.png'.

            Image.asset('images/inAppIcon.png'),

            //The second child of the column is a Row widget containing two Text widgets:
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // The first Text widget displays the text "Forget" with a font size of 30 and the color AppThemeColor.pureBlackColor.

              children: [
                Text(
                  'Forget',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppThemeColor.pureBlackColor,
                    fontSize: 30,
                  ),
                ),
                Text(
                  'Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppThemeColor.darkBlueColor,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //A Text widget with the text "Phone Number", styled with a font size of Dimensions.fontSizeDefault, a font weight of FontWeight.w600, and the color AppThemeColor.pureBlackColor.
                const Text(
                  'Phone Number',
                  style: TextStyle(
                    color: AppThemeColor.pureBlackColor,
                    fontSize: Dimensions.fontSizeDefault,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                //A Row widget with two Expanded widgets representing the prefix field and the phone number field:
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppThemeColor.pureWhiteColor,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(hintText: '+61'),
                        ),
                      ),
                    ),
                    //A SizedBox with a height of 15 pixels separates the phone number input section from the "Send OTP" button.
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppThemeColor.pureWhiteColor,
                        ),
                        child: TextFormField(
                          decoration:
                              const InputDecoration(hintText: '413525565'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: InkWell(
                    // onTap: () => RouterClass().otpScreeRoute(context: context),
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppThemeColor.darkBlueColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      //The "Send OTP" button is implemented using an InkWell widget wrapped in a Center widget. However, the onTap function for the button is currently commented out.

                      child: const Text(
                        'Send OTP',
                        style: TextStyle(
                          color: AppThemeColor.pureWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //There is an empty SizedBox at the end, which doesn't have any content.
            const SizedBox(),
          ],
          //Overall, this _bodyView() method creates a UI for the Forget Password Screen with an image, "Forget Password" text, a phone number input section, and a button to send the OTP (though the logic for handling OTP is not implemented in this code snippet).
        ));
  }
}
