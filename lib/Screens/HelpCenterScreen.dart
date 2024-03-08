import 'package:flutter/material.dart';
// Flutter Material package for widgets and UI components
import 'package:partner/Utils/dimensions.dart';

import '../Utils/AppConstents.dart';
// Custom utility file for application constants.
import '../Utils/Colors.dart';
// Custom utility file for application colors.

class HelpCenterScreen extends StatefulWidget {
  // Defining a stateful widget HelpCenterScreen that extends StatefulWidget. The widget takes no required parameters.
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
//   Defining the _HelpCenterScreenState class, which extends the State class for managing the state of the widget.
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;
// Inside the state class, two variables _screenWidth and _screenHeight are declared, and they are assigned the width and height of the device screen using MediaQuery.

  @override
  Widget build(BuildContext context) {
    // Widget build(BuildContext context): This is an overridden method from the State class and is called whenever the widget needs to be rebuilt. It returns the UI for the widget.

    return Scaffold(
      // return Scaffold(body: _bodyView());: In the build method, you are returning a Scaffold widget with the _bodyView() method as its body. The Scaffold widget is a basic structure for implementing Material Design layouts in Flutter apps. The _bodyView() method, which is not shown in the provided code, is expected to return a widget that will be displayed as the main content of the Scaffold.

      body: SafeArea(
        child: _bodyView(),
      ),
    );
  }

  Widget _bodyView() {
    // return Container(...): The _bodyView() method returns a Container widget as the root widget.

    return Container(
      height: _screenHeight,
      // height: _screenHeight, width: _screenWidth,: The height and width properties of the Container are set to _screenHeight and _screenWidth, respectively. These variables likely represent the height and width of the screen.

      width: _screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: const BoxDecoration(
        // decoration: const BoxDecoration(color: AppThemeColor.backGroundColor),: The Container has a BoxDecoration that sets its background color to AppThemeColor.backGroundColor. It seems like AppThemeColor is a custom class or file that provides color definitions for the app.

        color: AppThemeColor.backGroundColor,
      ),
      child: Column(
        // Inside the Container, there is a Column widget as its child, representing a vertical arrangement of widgets.

        children: [
          AppConstents().topBarViewWithBack(context: context),
          // AppConstents().topBarViewWithBack(context: context): This seems to be a custom widget representing the top bar view with a back button. It receives the context as an argument.

          const SizedBox(
            height: 40,
            //   SizedBox(height: 40): This is a SizedBox widget with a height of 40 pixels, providing some spacing between the top bar view and the ListView.builder.
          ),
          Expanded(
            //The Expanded widget takes the remaining vertical space and allows its child, a SingleChildScrollView, to scroll if needed.
            child: SingleChildScrollView(
              //The SingleChildScrollView wraps a Column, allowing the content to be scrollable when the content exceeds the available height on the screen.
              child: Column(
                children: [
                  const Row(
                    //A Row widget is used to display two Text widgets side by side, forming the title "Rise a Ticket."
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Rise a ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppThemeColor.pureBlackColor,
                          fontSize: 30,
                        ),
                      ),
                      //The first part is in black color, and the second part is in dark blue color.
                      Text(
                        'Ticket',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppThemeColor.darkBlueColor,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        //It contains a Text widget displaying "Subject" in black color and a TextFormField widget for users to enter their subject.
                        const Text(
                          'Subject',
                          style: TextStyle(
                            color: AppThemeColor.pureBlackColor,
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        //It contains a Text widget displaying "Subject" in black color and a TextFormField widget for users to enter their subject.

                        Container(
                          decoration: const BoxDecoration(
                            color: AppThemeColor.pureWhiteColor,
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                hintText: 'Enter your subject'),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Description',
                          style: TextStyle(
                            color: AppThemeColor.pureBlackColor,
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppThemeColor.pureWhiteColor,
                          ),
                          child: TextFormField(
                            maxLines: 4,
                            decoration: const InputDecoration(
                                hintText: 'Enter your description'),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Description',
                          style: TextStyle(
                            color: AppThemeColor.pureBlackColor,
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Row(
                          //A Row is used to show an icon (attachment icon) and the text "Choose here (PDF, PNG, JPG)" for users to indicate that they can attach files to their request.
                          children: [
                            Icon(
                              Icons.attachment,
                              color: AppThemeColor.dullFontColor,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Chose here (PDF, PNG, JPG)',
                              style: TextStyle(
                                color: AppThemeColor.dullFontColor,
                                fontSize: Dimensions.fontSizeDefault,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        //The Center widget wraps a Container, which contains a button labeled "Signup" with a dark blue background.
                        Center(
                          child: Container(
                            width: 150,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppThemeColor.darkBlueColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Signup',
                              style: TextStyle(
                                color: AppThemeColor.pureWhiteColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          //Two SizedBox widgets with a height of 100 pixels are added to create vertical spacing between the content and the bottom of the screen.
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

 /* Widget _singleTabView({
    required IconData iconData,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                iconData,
                size: 22,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: AppThemeColor.pureBlackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: Dimensions.fontSizeLarge,
                ),
              )
            ],
          ),
          const Icon(
            Icons.keyboard_arrow_right_rounded,
            color: AppThemeColor.pureBlackColor,
            size: 28,
          )
        ],
      ),
    );
  }*/
}
