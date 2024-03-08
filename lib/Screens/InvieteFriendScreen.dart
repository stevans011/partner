import 'package:flutter/material.dart';
import 'package:partner/Utils/dimensions.dart';

import '../Utils/AppConstents.dart';
import '../Utils/Colors.dart';

//The class InviteFriendScreen extends StatefulWidget, which means it represents a widget that has mutable state. This allows the widget to change its appearance and behavior over time.
class InviteFriendScreen extends StatefulWidget {
  const InviteFriendScreen({super.key});

  @override
  //The createState() method returns an instance of _InviteFriendScreenState. This method is called when the widget is inserted into the widget tree and creates the associated mutable state for this widget.
  State<InviteFriendScreen> createState() => _InviteFriendScreenState();
}

//_InviteFriendScreenState is a private class the state class associated with the InviteFriendScreen widget. in short  it is a state that belongs to the LoginScreen widget.
class _InviteFriendScreenState extends State<InviteFriendScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  @override  //The @override annotation indicates that this method is intended to override a method from a superclass, usually from a widget's base class.
  Widget build(BuildContext context) {
    //The Scaffold widget provides a basic structure for a typical mobile app screen, including an app bar, body, and other optional features like floating action buttons, drawers, etc.
    return Scaffold(
      //The SafeArea widget is used to ensure that its child's content is not obscured by system overlays, such as the system status bar or device notches. It pads its child's content to avoid overlapping with these areas.
      body: SafeArea(
        child: _bodyView(), //The _bodyView() is likely a private method that returns another widget to be displayed as the main content of the Scaffold.
      ),
    );
  }

  Widget _bodyView() {
    //The Container is set to occupy the full screen width and height, as specified by the _screenWidth and _screenHeight variables.
    return Container(
      height: _screenHeight,
      width: _screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7), //This padding creates space around the content of the container.
      decoration: const BoxDecoration(
        color: AppThemeColor.backGroundColor,
      ),
      //Column widget that contains the main content of the screen, arranged vertically.
      child: Column(
        children: [
          AppConstents().topBarViewWithBack(context: context), //This method defined in the AppConstants class, returns a widget representing the top bar view with a back button or back icon. The context parameter is passed to this method, allowing it to build the appropriate widget.
          //SizedBox with a height of 15 pixels, creating a vertical space between the top bar view and the rest of the content.
          const SizedBox(
            height: 40,
          ),
          //The Expanded widget takes up the remaining vertical space.
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Display text "Sent an" with specific color and size
                    Text(
                      'Sent an ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppThemeColor.pureBlackColor,
                        fontSize: Dimensions.fontSizeExtraLarge,
                      ),
                    ),
                    //Display text "Invitation" with specific color and size
                    Text(
                      'Invitation',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppThemeColor.darkBlueColor,
                        fontSize: Dimensions.fontSizeExtraLarge,
                      ),
                    ),
                    //Display text "to your friend" with specific color and size
                    Text(
                      'to your friend',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppThemeColor.pureBlackColor,
                        fontSize: Dimensions.fontSizeExtraLarge,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10), //This padding creates space around the content of the container.
                  margin: const EdgeInsets.symmetric(horizontal: 15), //The container has vertical margin of 15 pixels, providing spacing between this container and other elements.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, //Aligns the children at the left side of the Column.
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      //Display "phone Number" text with specific color ,size and weight
                      const Text(
                        'Phone Number',
                        style: TextStyle(
                          color: AppThemeColor.pureBlackColor,
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          //The Expanded widget takes up the remaining vertical space.
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppThemeColor.pureWhiteColor,
                              ),
                              //TextFormField, which is a widget that allows users to input text.
                              child: TextFormField(
                                // hintText acts as a placeholder text to guide the user on what to write in the input field.
                                decoration:
                                    const InputDecoration(hintText: '+61'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),

                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppThemeColor.pureWhiteColor,
                              ),
                              //TextFormField, which is a widget that allows users to input text.
                              child: TextFormField(
                                // hintText acts as a placeholder text to guide the user on what to write in the input field.
                                decoration: const InputDecoration(
                                    hintText: '413525565'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Center(
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppThemeColor.darkBlueColor,
                            borderRadius: BorderRadius.circular(4), //customized container with  rounded corners with a circular border radius of 4  pixels.
                          ),
                          //Display Text "send Invitation" with specific color
                          child: const Text(
                            'Send Invitation',
                            style: TextStyle(
                              color: AppThemeColor.pureWhiteColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
/*
  Widget _singleTabView({
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
