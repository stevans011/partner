import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/Utils/Router.dart';

import 'dimensions.dart';

//this class contains various utility functions and constants for an application.
class AppConstents {
  static const String appName = 'Partner'; //A constant string representing the name of the app.
  static const String appVersion = '1.0.0'; // A constant string representing the version of the app

  //A list of strings representing different categories.
  List<String> categoriesList = [
    'Cat\n1',
    'Cat\n2',
    'Cat\n3',
    'Cat\n4',
    'Cat\n5',
  ];

  //A function that returns a Container widget, which displays a loading view with a message and an image.
  Widget loaderView({
    required String message, //The message to be displayed in the loading view.
    required String image, //The image asset path to be displayed in the loading view.
    required double height, //The height of the loading view.
    required double width, //The width of the loading view.
  }) {
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 30), //sets a horizontal margin of 30 pixels on both sides
      decoration: BoxDecoration(
        color: AppThemeColor.pureWhiteColor, //set background color of the container
        borderRadius: BorderRadius.circular(20), //The container has a circular border with a radius of 20 pixels.
        //The container has a shadow to give it a raised effect. The shadow color is set to a semi-transparent grey (Colors.grey.withOpacity(0.5)), with a spreadRadius of 5, blurRadius of 7, and offset of (0, 3) to change the position of the shadow.
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround, //arranges its children in a vertical column with equal space distribution around each child
        children: [
          // text displays the message provided as a parameter to the loaderView function.
          Text(
            message,
            style: TextStyle(
              color: AppThemeColor.pureBlackColor,
              fontSize: Dimensions.fontSizeExtraLarge,
              fontWeight: FontWeight.w400,
            ), //set customized text style
          ),
          //widget displays an image from the specified asset image.
          // The image has a fixed width of 40 pixels as set by the width parameter.
          Image.asset(
            image,
            width: 40,
          ),
        ],
      ),
    );
  }


  //A function that returns a Row widget representing the top bar view with icons for notifications and a pop-up menu.
  Widget topBarView({required BuildContext context}) { //The BuildContext passed as a parameter is used for navigation purposes.
    //widget that arranges its children horizontally in a row.
    return Row(
      children: [
        const Expanded( // Expanded widget allows this child to occupy any remaining horizontal space in the row after other children have been laid out.
          child: SizedBox(), //this is used to give this child some initial size (which will be ignored when it is expanded).
        ),
        InkWell( //this widget It represents a clickable area in the UI and is used to trigger an action when tapped
          onTap: () => RouterClass().notificationsScreenRoute(context: context), //it navigates to the notifications screen by calling the notificationsScreenRoute method of the RouterClass and passing the context as an argument.
          // Icon widget representing the "notifications_active_outlined" icon from the material icons library. The icon is displayed with the color set to AppThemeColor.dullFontColor.
          child: const Icon(
            Icons.notifications_active_outlined,
            color: AppThemeColor.dullFontColor,
          ),
        ),
        //with a fixed width of 10 pixels, which creates a horizontal space between the notifications icon and the next child.
        const SizedBox(
          width: 10,
        ),
        popMenu(context: context), //this widget represents a pop-up menu button.
      ],
    );
  }


  //A function that returns a Row widget representing the top bar view with a back button, icons for notifications, and a pop-up menu.
  Widget topBarViewWithBack({required BuildContext context}) { //BuildContext passed as a parameter is used for navigation purposes.
    //The function returns a Row widget that arranges its children horizontally in a row.
    return Row(
      children: [
        //InkWell widget representing the back button. This button allows the user to navigate back to the previous screen using Navigator.pop(context) when tapped.
        InkWell(
          onTap: () => Navigator.pop(context), //When the back button is tapped, it calls Navigator.pop(context) to pop the current route from the navigation stack, effectively returning to the previous screen.
         //Icon widget representing the "arrow_back_ios_new" icon from the material icons library. The icon color is set to AppThemeColor.darkBlueColor.
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppThemeColor.darkBlueColor,
          ),
        ),
        //Expanded widget allows this child to occupy any remaining horizontal space in the row after other children have been laid out.
        const Expanded(
          child: SizedBox(), //this is used to give this child some initial size (which will be ignored when it is expanded).
        ),
        InkWell(  //this widget It represents a clickable area in the UI and is used to trigger an action when tapped
          onTap: () => RouterClass().notificationsScreenRoute(context: context), //it navigates to the notifications screen by calling the notificationsScreenRoute method of the RouterClass and passing the context as an argument.
          // Icon widget representing the "notifications_active_outlined" icon from the material icons library. The icon is displayed with the color set to AppThemeColor.dullFontColor.
          child: const Icon(
            Icons.notifications_active_outlined,
            color: AppThemeColor.dullFontColor,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        popMenu(context: context), //this widget represents a pop-up menu button.
      ],
    );
  }


  // this function is a Flutter widget that returns a PopupMenuButton. This pop-up menu button provides a list of options (menu items) to choose from when the user taps on it.
  Widget popMenu({required BuildContext context}) { //BuildContext passed as a parameter is used for navigation purposes.
    return PopupMenuButton<String>( //this is the pop-up menu button. This widget displays a list of menu items when tapped.
      initialValue: '', // set to an empty string, which means no item is initially selected in the pop-up menu.
      // Callback that sets the selected popup menu item.
      //onSelected callback is triggered when a menu item is selected from the pop-up menu. It takes the selected item as an argument and based on the selected item, it performs specific actions.
      onSelected: (item) {
        //If the selected item is 'Profile', it navigates to the 'editProfileRoute' using the RouterClass.
        if (item == 'Profile') {
          RouterClass().editProfileRoute(context: context);
        } else if (item == 'FAQ\'s') {
          RouterClass().faqsScreenRoute(context: context);
        } else if (item == 'help Center') {
          RouterClass().helpCenterScreenRoute(context: context);
        } else if (item == 'Logout') {
          FirebaseAuth.instance.signOut().then(
                (value) => RouterClass().loginScreeRoute(context: context),
              );
        }
      },
      //itemBuilder callback is responsible for building the list of menu items that will be displayed in the pop-up menu. It takes the context as an argument and returns a list of PopupMenuEntry<String>.
      //Each menu item is created using the _singleMenuItem function, which takes an IconData and a title as input and returns a PopupMenuItem<String> widget.
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        _singleMenuItem(
          iconData: Icons.person,
          title: 'Profile',
        ),
        _singleMenuItem(
          iconData: Icons.help_outline,
          title: 'FAQ\'s',
        ),
        _singleMenuItem(
          iconData: Icons.person_pin_outlined,
          title: 'help Center',
        ),
        _singleMenuItem(
          iconData: Icons.logout,
          title: 'Logout',
        ),
      ],
    );
  }


  //_singleMenuItem function, which takes an IconData and a title as input and returns a PopupMenuItem<String> widget.
  //The _singleMenuItem function creates a row with an icon and the title of the menu item.
  PopupMenuEntry<String> _singleMenuItem({
    required IconData iconData,
    required String title,
  }) {
    return PopupMenuItem<String>(
      value: title,
      child: Row(
        children: [
          Icon(iconData),
          const SizedBox(
            width: 7,
          ),
          Text(title),
        ],
      ),
    );
  }
}
