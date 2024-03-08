import 'package:flutter/material.dart';
import 'package:partner/Screens/AfterQuestionsScreen.dart';
import 'package:partner/Screens/ChosQuizCategoryScreen.dart';
import 'package:partner/Screens/ConnectScreen.dart';
import 'package:partner/Screens/CreateNewAccount.dart';
import 'package:partner/Screens/DashBoardScreen.dart';
import 'package:partner/Screens/EditProfileScreen.dart';
import 'package:partner/Screens/FaqsScreen.dart';
import 'package:partner/Screens/ForgetPasswordScreen.dart';
import 'package:partner/Screens/HelpCenterScreen.dart';
import 'package:partner/Screens/InvieteFriendScreen.dart';
import 'package:partner/Screens/LoginScreen.dart';
import 'package:partner/Screens/NotificationScreen.dart';
import 'package:partner/Screens/OtpScreen.dart';
import 'package:partner/Screens/SingleCategoryHistoryScreen.dart';
import 'package:partner/Screens/SingleHistoryScreen.dart';

import '../Screens/SingleCategoryScreen.dart';


//this class contains a collection of methods to navigate to various screens in your application. These methods use the Navigator.push and Navigator.pushAndRemoveUntil functions to manage the navigation stack.
//Each method corresponds to a specific screen in your app and takes a BuildContext object as a required parameter.
// The BuildContext is necessary for navigation, as it provides information about the location of the widget within the widget tree.

class RouterClass {
  //Navigates to the LoginScreen and removes all previous routes from the stack.
  loginScreeRoute({required BuildContext context}) =>
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false);

// Navigates to the CreateNewAccount screen.
  createNewAccountScreeRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateNewAccount(),
        ),
      );
  //Navigates to the ForgetPasswordScreen.
  forgetPasswordScreeRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ForgetPasswordScreen(),
        ),
      );

  //Navigates to the OtpScreen and passes various required parameters.
  otpScreeRoute({
    required BuildContext context,
    required String phoneNumber,
    required String userName,
    required String password,
    required bool createAccount,
    required String verificationId,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            phoneNumber: phoneNumber,
            password: password,
            createAccount: createAccount,
            userName: userName,
            verificationId: verificationId,
          ),
        ),
      );


  //Navigates to the DashBoardScreen and removes all previous routes from the stack.
  dashBoardScreeRoute({required BuildContext context}) =>
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const DashBoardScreen(),
          ),
          (route) => false);

  //Navigates to the SingleHistoryScreen.
  singleHistoryScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SingleHistoryScreen(),
        ),
      );

  //Navigates to the SingleCategoryHistoryScreen.
  singleCategoryHistoryScreenRoute({required BuildContext context}) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SingleCategoryHistoryScreen(),
        ),
      );


 // Navigates to the NotificationScreen.
  notificationsScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
        ),
      );

  //Navigates to the AfterQuestionsScreen.
  afterQuestionsScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AfterQuestionsScreen(),
        ),
      );

  //Navigates to the EditProfileScreen.
  editProfileRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
        ),
      );


  //Navigates to the ConnectScreen.
  connectScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ConnectScreen(),
        ),
      );

  //Navigates to the FaqsScreen.
  faqsScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FaqsScreen(),
        ),
      );


  // Navigates to the HelpCenterScreen.
  helpCenterScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HelpCenterScreen(),
        ),
      );

  //Navigates to the InviteFriendScreen.
  inviteFriendScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const InviteFriendScreen(),
        ),
      );

  //Navigates to the ChosQuizCategoryScreen.
  choseCategoryScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChosQuizCategoryScreen(),
        ),
      );


  //Navigates to the SingleCategoryScreen and passes the selectedCategory as a parameter.
  singleCategoryScreenRoute(
          {required BuildContext context, required String selectedCategory}) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SingleCategoryScreen(
            selectedCategory: selectedCategory,
          ),
        ),
      );
}
