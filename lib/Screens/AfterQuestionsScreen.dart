import 'package:flutter/material.dart';
// Flutter Material package for widgets and UI components.
import 'package:partner/Utils/dimensions.dart';
// Custom utility file for dimensions
import '../Utils/AppConstents.dart';
//  Custom utility file for application constants.
import '../Utils/Colors.dart';

// Custom utility file for application colors.
class AfterQuestionsScreen extends StatefulWidget {
  // Defining a stateful widget AfterQuestionsScreen that extends StatefulWidget. The widget takes no required parameters.
  const AfterQuestionsScreen({super.key});

  @override
  State<AfterQuestionsScreen> createState() => _AfterQuestionsScreenState();
//   Defining the _AfterQuestionsScreenState class, which extends the State class for managing the state of the widget.
}

class _AfterQuestionsScreenState extends State<AfterQuestionsScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;
  // Inside the state class, two variables _screenWidth and _screenHeight are declared,and they are assigned the width and height of the device screen using MediaQuery.

  @override
  Widget build(BuildContext context) {
    // Widget build(BuildContext context): This is the build method, which is responsible for building and returning the widget tree. It receives a BuildContext object as an argument, which is typically used to access the theme, localization, and other properties from the widget tree.
    return Scaffold(
      body: SafeArea(
        // The build method is overridden to construct the widget tree for this screen. It returns a Scaffold with a SafeArea as its body.
        child: _bodyView(),
        //   The _bodyView method is defined to build the main content of the screen. It consists of a Container with a height and width equal to the screen size. The container has a background color and padding.
      ),
    );
  }

  Widget _bodyView() {
    return Container(
      height: _screenHeight,
      width: _screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: const BoxDecoration(
        color: AppThemeColor.backGroundColor,
      ),
      // The container has a background height,width,color and padding.
      child: Column(
        // Inside the container, there's a Column widget containing the following children:

        // A top bar view with a back button. This is likely a custom widget defined in AppConstents.
        children: [
          AppConstents().topBarViewWithBack(context: context),
          const SizedBox(
            height: 40,
            //   A SizedBox with a height of 40 for vertical spacing.
          ),
          Column(
            // Another Column widget with the following children:
            children: [
              Image.asset('images/robot.png'),
              // An Image.asset widget displaying an image named 'robot.png'.
              const SizedBox(
                height: 20,
                //   A SizedBox with a height of 20 for vertical spacing.
              ),
              const Text(
                'AI Calculating Your Result',
                style: TextStyle(
                  color: AppThemeColor.darkBlueColor,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.fontSizeExtraLarge,
                ),
                // A Text widget displaying the message "AI Calculating Your Result" with specific text styles (color, font weight, and size).
              ),
              const SizedBox(
                height: 30,
                //   A SizedBox with a height of 30 for vertical spacing.
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // A Row widget with two buttons wrapped in InkWell widgets:
                children: [
                  InkWell(
                    child: Container(
                      width: _screenWidth / 2.5,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppThemeColor.darkBlueColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Proceed to result',
                        style: TextStyle(
                          color: AppThemeColor.pureWhiteColor,
                        ),
                      ),
                    ),
                    //   The first button has a dark blue background with the text "Proceed to result".
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: _screenWidth / 2.5,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppThemeColor.pureWhiteColor,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          width: 0.4,
                          color: AppThemeColor.grayColor,
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppThemeColor.pureBlackColor,
                        ),
                      ),
                    ),
                    //   The second button has a white background with a black border and the text "Cancel". Tapping this button will navigate back to the previous screen (Navigator.pop(context)).
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
