import 'package:flutter/material.dart';
// Flutter Material package for widgets and UI components.
import 'package:partner/Utils/dimensions.dart';
// package:partner/Utils/dimensions.dart: Custom utility file for dimensions (probably for consistent spacing, etc.).
import '../Firebase/FirebaseDatabaseHelper.dart';
// Custom utility file for Firebase Services.
import '../Objects/UserObject.dart';
// Custom utility file for User Objects.
import '../Utils/AppConstents.dart';
// Custom utility file for application constants.
import '../Utils/Colors.dart';
// Custom utility file for application colors.

class ConnectScreen extends StatefulWidget {
  // Defining a stateful widget ConnectScreen that extends StatefulWidget. The widget takes no required parameters.
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
//   Defining the _ConnectScreenState class, which extends the State class for managing the state of the widget.
}

class _ConnectScreenState extends State<ConnectScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;
  // Inside the state class, two variables _screenWidth and _screenHeight are declared, and they are assigned the width and height of the device screen using MediaQuery.

  final TextEditingController _codeController = TextEditingController();
  // _codeController: This controller is intended to be used for capturing the input of the "code" field. It allows you to listen to changes and retrieve the text entered by the user in the "code" input field.
  final TextEditingController _phoneNumberController = TextEditingController();
  // _phoneNumberController: This controller is intended to be used for capturing the input of the "phone number" field. Like _codeController, it allows you to listen to changes and retrieve the text entered by the user in the "phone number" input field.
  @override
  // @override: This annotation indicates that the following method is overriding a method from its superclass, in this case, the build method from the StatelessWidget class.
  Widget build(BuildContext context) {
    // Widget build(BuildContext context): This is the build method, which is responsible for building and returning the widget tree. It receives a BuildContext object as an argument, which is typically used to access the theme, localization, and other properties from the widget tree.
    return Scaffold(
      // return Scaffold(...): The build method returns a Scaffold widget. A Scaffold is a basic material design structure in Flutter that provides a framework for implementing the basic material design visual layout structure.
      body: SafeArea(
        // body: SafeArea(...): Within the Scaffold, the SafeArea widget is used as the body. The SafeArea widget ensures that its child's content is positioned within the visible part of the screen, avoiding areas like notches and system bars.
        child: _bodyView(),
        //   child: _bodyView(): The SafeArea widget has a child provided by the _bodyView() method. This method is likely defined in the same class (but it's not included in the code you provided). The _bodyView() method should return a widget that represents the main content of the ConnectScreen.
      ),
    );
  }

  UserObject? searchUser;

  Widget _bodyView() {
    // The _bodyView() method returns a Container widget that represents the main content of the ConnectScreen. Let's break down the structure of the content:
    return Container(
      // Container: The outermost widget is a Container that takes the full width and height of the screen. It has padding to create some spacing from the edges and is decorated with a background color defined by AppThemeColor.backGroundColor.
      height: _screenHeight,
      width: _screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: const BoxDecoration(
        color: AppThemeColor.backGroundColor,
      ),
      child: Column(
        // Column: The Container has a child Column, which allows laying out its children vertically. The Column contains multiple widgets, including the top bar, phone number input fields, a "Search for partner" button, and possibly information about the searched user.
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppConstents().topBarView(context: context),
          // AppConstents().topBarView(context: context): This is a custom widget that represents the top bar view of the screen. The implementation is not included in the provided code snippet, but it's likely a header or app bar that displays some relevant information.
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Enter the Phone Number',
            style: TextStyle(
              color: AppThemeColor.pureBlackColor,
              fontSize: Dimensions.fontSizeDefault,
              fontWeight: FontWeight.w600,
            ),
          ),
          // Phone Number Input: The phone number input is represented by two TextFormField widgets placed in a Row. The user can enter the country code (e.g., +61) in the first TextFormField using the _codeController, and the actual phone number in the second TextFormField using the _phoneNumberController.
          Row(
            children: [
              //Expanded widget takes up one part of the available horizontal space (flex: 1)
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppThemeColor.pureWhiteColor,
                  ),
                  //This is a widget used for text input.
                  child: TextFormField(
                    controller: _codeController, //ses the _codeController to control the input
                    decoration: const InputDecoration(hintText: '+61'),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              //Expanded widget takes up three parts of the available horizontal space (flex: 3)
              Expanded(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppThemeColor.pureWhiteColor,
                  ),
                  child: TextFormField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(hintText: '413525565'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            // "Search for partner" Button: Below the phone number input fields, there is an InkWell widget that serves as a button. When tapped (onTap), it calls the getUserSearch() method, which is not shown in the provided code snippet. This button is styled with a dark blue background color and displays the text "Search for partner" in white.
            onTap: () => getUserSearch(),
            child: Container(
              width: _screenWidth,
              decoration: BoxDecoration(
                color: AppThemeColor.darkBlueColor,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(vertical: 9),
              alignment: Alignment.center,
              child: const Text(
                'Search for partner',
                style: TextStyle(
                  color: AppThemeColor.pureWhiteColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          if (searchUser != null)
            _singleTabView(
                user: searchUser!.uid.isNotEmpty, userData: searchUser!),
          // _singleTabView(user: true),
          //   _singleTabView: This appears to be a custom widget as well, responsible for displaying information about the searched user. It is conditionally shown based on whether the searchUser object is not null. If searchUser is not null, it displays information about the user, such as their UID and other user data.
        ],
      ),
    );
  }

  Widget _singleTabView({required bool user, required UserObject userData}) {
    // _singleTabView: This method takes two required parameters, user (a boolean indicating if it's the current user's data) and userData (a UserObject representing the user's data to display). It returns a Container with a row layout displaying user information.
    //
    // If user is true, it displays a blue "Send invitation" button.
    // If user is false, it displays two buttons: a purple "Send invitation" button and a blue "invite friend to app" button. This is presumably for inviting someone else to the app.
    return Container(
      width: _screenWidth,
      decoration: BoxDecoration(
        color: AppThemeColor.pureWhiteColor,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Row(
        children: [
          Image.asset(
            'images/profile.png',
            width: 40,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData.userName,
                  style: const TextStyle(
                    color: AppThemeColor.pureBlackColor,
                    fontSize: Dimensions.fontSizeDefault,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  userData.phoneNumber,
                  style: const TextStyle(
                    color: AppThemeColor.dullFontColor,
                    fontSize: Dimensions.fontSizeSmall,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          user
              ? Container(
                  decoration: BoxDecoration(
                    color: AppThemeColor.darkBlueColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: const Text(
                    'Send invitation',
                    style: TextStyle(
                      color: AppThemeColor.pureWhiteColor,
                      fontSize: Dimensions.fontSizeExtraSmall,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppThemeColor.purpleColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      child: const Text(
                        'Send invitation',
                        style: TextStyle(
                          color: AppThemeColor.pureWhiteColor,
                          fontSize: Dimensions.fontSizeExtraSmall,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppThemeColor.darkBlueColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      child: const Text(
                        'invite friend to app',
                        style: TextStyle(
                          color: AppThemeColor.pureWhiteColor,
                          fontSize: Dimensions.fontSizeExtraSmall,
                        ),
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }

  Future<void> getUserSearch() async {
    // Future<void> getUserSearch(): This method is called when the "Search for partner" button is tapped. It retrieves the phone number from the _codeController and _phoneNumberController, combines them into a full phone number, and uses FirebaseDatabaseHelper to fetch the user data associated with that phone number.
    //
    // If the user is found (userData is not null), it updates the searchUser state with the retrieved data using setState.
    // If the user is not found, it creates a new UserObject with the provided phone number and assigns it to searchUser.
    String phoneNumber =
        '${_codeController.text}${_phoneNumberController.text}';

    await FirebaseDatabaseHelper()
        .getUsersByPhoneNumber(phoneNumber: phoneNumber)
        .then((userData) {
      if (userData != null) {
        setState(() {
          searchUser = userData;
        });
      } else {
        setState(() {
          searchUser = UserObject(
              uid: '',
              userName: 'User Name',
              password: '',
              phoneNumber: phoneNumber);
        });
      }
    });
    //   setState: The setState method is called within getUserSearch to update the state of the ConnectScreen with the new searchUser data. This triggers a rebuild of the UI, and the _singleTabView will display the user information or the "Send invitation" buttons based on the searchUser data.
  }
}
