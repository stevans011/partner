import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partner/Utils/AppConstents.dart';
import 'package:partner/Utils/dimensions.dart';

import '../Firebase/FirebaseDatabaseHelper.dart';
import '../Objects/UserObject.dart';
import '../Utils/Colors.dart';
import '../Utils/Router.dart';

//The AccountScreen class is a StatefulWidget that extends State<AccountScreen>.
class AccountScreen extends StatefulWidget {
  const AccountScreen({
    super.key,
  });

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

//Inside the _AccountScreenState class, there are several methods used to fetch and display user data from Firebase:
class _AccountScreenState extends State<AccountScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  UserObject? userData;
//getUserData(): Fetches basic user data (uid, username, and phoneNumber).
  Future<void> getUserData() async {
    //The await keyword is used to wait for the completion of the getUsers() method of the FirebaseDatabaseHelper class.
    // This method is expected to return a Future containing the user data from the Firebase database.
    await FirebaseDatabaseHelper().getUsers().then((user) {
      if (user != null) {
        setState(() {
          userData = user;
        });
      }
    });
  }

  //getFullUserData(): Fetches full user data (additional information such as password) and sets it to the userData variable.
  Future<void> getFullUserData() async {
    await FirebaseDatabaseHelper().getFullUsers().then((user) {
      if (user != null) {
        setState(() {
          userData = UserObject(
              uid: user.uid!,
              userName: user.userName!,
              password: '',
              phoneNumber: user.phoneNumber!);
        });
      } else {
        getUserData();
      }
    });
  }

//initState(): Calls getFullUserData() to initialize the userData when the screen is created.
  @override
  void initState() {
    getFullUserData();
    super.initState();
  }

  //The build method creates the main UI of the screen.
  @override
  Widget build(BuildContext context) {
    //It returns a Scaffold with a SafeArea widget as its body, wrapping the _bodyView() method.
    return Scaffold(
      body: SafeArea(
        child: _bodyView(),
      ),
    );
  }

  Widget _bodyView() {
    //The _bodyView() method returns the main content of the screen wrapped in a Container.
    return Container(
      height: _screenHeight,
      width: _screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: const BoxDecoration(
        color: AppThemeColor.backGroundColor,
      ),
      child: Column(
        children: [
          //A top bar view created by the AppConstants().topBarView() method.
          AppConstents().topBarView(context: context),
          //The Expanded widget takes up the remaining vertical space.
          Expanded(
            //A SingleChildScrollView containing user information, options, and settings.
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      // These Image.asset widgets load and display images from the assets of the app with specific width.
                      Image.asset(
                        'images/profile.png',
                        width: _screenWidth / 3,
                      ),
                      //A user profile image with an edit icon (Icons.edit_outlined) on the bottom right.

                      Container(
                        decoration: BoxDecoration(
                          color: AppThemeColor.pureBlackColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(5),
                        //Display icon edit_outlined with specific color and size
                        child: const Icon(
                          Icons.edit_outlined,
                          color: AppThemeColor.pureWhiteColor,
                          size: 17,
                        ),
                      ),
                    ],
                  ),
                  //The user's name and phone number displayed using Text widgets.
                  Text(
                    userData != null ? userData!.userName : '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.fontSizeExtraLarge,
                    ),
                  ),
                  Text(
                    userData != null ? userData!.phoneNumber : '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.fontSizeExtraLarge,
                      color: AppThemeColor.dullFontColor,
                    ),
                  ),
                  //The options and settings section is implemented as a Column containing several GestureDetector
                  Column(
                    children: [
                      //Each GestureDetector represents a different option or setting that the user can interact with.
                      GestureDetector(
                        //Options include "Edit Profile," "Payment," "Help Center," "FAQs," "Invite Friends," and "Logout."
                        onTap: () async => await RouterClass()
                            .editProfileRoute(context: context)
                            .then((value) {
                          getFullUserData();
                        }),
                        child: _singleTabView(
                          iconData: Icons.person,
                          title: 'Edit Profile',
                        ),
                      ),
                      //This widget is used to detect gestures, such as taps, swipes, etc., on its child widget.
                      GestureDetector(
                        child: _singleTabView(
                          iconData: Icons.payments,
                          title: 'Payment',
                        ),
                      ),
                      //When the user taps on an option, it navigates to the corresponding screen using the RouterClass methods.
                      GestureDetector(
                        onTap: () => RouterClass()
                            .helpCenterScreenRoute(context: context),
                        child: _singleTabView(
                          iconData: Icons.person_pin_outlined,
                          title: 'help Center',
                        ),
                      ),
                      //When the user taps on the "FAQ's" option, the onTap function calls the faqsScreenRoute method from RouterClass,
                      GestureDetector(
                        onTap: () =>
                            RouterClass().faqsScreenRoute(context: context),
                        child: _singleTabView(
                          iconData: Icons.help_outline,
                          title: 'FAQ\'s',
                        ),
                      ),
                      //When the user taps on the "Invite Friends" option, the onTap function calls the inviteFriendScreenRoute method from RouterClass,
                      GestureDetector(
                        onTap: () => RouterClass()
                            .inviteFriendScreenRoute(context: context),
                        child: _singleTabView(
                          iconData: Icons.person_pin_outlined,
                          title: 'Invite Friends',
                        ),
                      ),
                      //
                      // The code snippet you provided shows three GestureDetector widgets with different onTap functions that handle specific actions when the corresponding options are tapped by the user. Let's take a closer look at each of them:
                      //
                      // FAQs Option:
                      // dart
                      // Copy code
                      // GestureDetector(
                      //   onTap: () => RouterClass().faqsScreenRoute(context: context),
                      //   child: _singleTabView(
                      //     iconData: Icons.help_outline,
                      //     title: 'FAQ\'s',
                      //   ),
                      // ),
                      // When the user taps on the "FAQ's" option, the onTap function calls the faqsScreenRoute method from RouterClass, which presumably navigates the user to the FAQ's screen. The faqsScreenRoute method is expected to handle the navigation logic. The option is displayed using the _singleTabView widget, which shows an icon with Icons.help_outline and the title "FAQ's."
                      //
                      // Invite Friends Option:
                      // dart
                      // Copy code
                      // GestureDetector(
                      //   onTap: () => RouterClass().inviteFriendScreenRoute(context: context),
                      //   child: _singleTabView(
                      //     iconData: Icons.person_pin_outlined,
                      //     title: 'Invite Friends',
                      //   ),
                      // ),
                      // When the user taps on the "Invite Friends" option, the onTap function calls the inviteFriendScreenRoute method from RouterClass, which is expected to handle the navigation to the "Invite Friends" screen. Similar to the previous option, the display is done using the _singleTabView widget with an icon Icons.person_pin_outlined and the title "Invite Friends."
                      //
                      // Logout Option:
                      // dart
                      // Copy code
                      // GestureDetector(
                      //   onTap: () {
                      //     FirebaseAuth.instance.signOut().then(
                      //       (value) => RouterClass().loginScreeRoute(context: context),
                      //     );
                      //   },
                      //   child: _singleTabView(
                      //     iconData: Icons.logout,
                      //     title: 'Logout',
                      //   ),
                      // ),
                      // When the user taps on the "Logout" option, the onTap function is triggered. It first calls FirebaseAuth.instance.signOut() to sign the user out from the app.
                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signOut().then(
                                (value) => RouterClass()
                                    .loginScreeRoute(context: context),
                              );
                        },
                        child: _singleTabView(
                          iconData: Icons.logout,
                          title: 'Logout',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //The _singleTabView() method takes two required parameters: iconData of type IconData and title of type String.
  Widget _singleTabView({
    required IconData iconData,
    required String title,
  }) {
    //It returns a Container widget that contains the row layout for the option.
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      //The background color of the Container is set to Colors.transparent, which makes the background transparent.
      color: Colors.transparent,
      //Inside the Container, the row is created using a Row widget.
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //It contains an Icon widget with the specified iconData and a size of 22 pixels.
              Icon(
                iconData,
                size: 22,
              ),
              //There's a SizedBox with a width of 15 pixels between the icon and the title.
              const SizedBox(
                width: 15,
              ),
              //A Text widget displays the title with a font size of Dimensions.fontSizeLarge, a font weight of FontWeight.w400, and the color AppThemeColor.pureBlackColor.
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
          //The second child of the main Row is an Icon widget with the Icons.keyboard_arrow_right_rounded icon.
          const Icon(
            Icons.keyboard_arrow_right_rounded,
            color: AppThemeColor.pureBlackColor,
            size: 28,
          )
        ],
      ),
    );
  }
}
