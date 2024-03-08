import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
// Custom utility file for Firebase Authentication.
import 'package:firebase_storage/firebase_storage.dart';
// Custom utility file for Firebase Storage Services.
import 'package:flutter/material.dart';
// Flutter utility file for for widgets and UI components.
import 'package:flutter/services.dart';
// Flutter utility file for Services.
import 'package:image_picker/image_picker.dart';
// Flutter utility file for Image pick from camera and gallery.
import 'package:partner/Firebase/FirebaseDatabaseHelper.dart';
// Flutter utility file for Firebase Database services.
import 'package:partner/Objects/FullUserObject.dart';
// Flutter utility file for Services.
import 'package:partner/Objects/UserObject.dart';
import 'package:partner/Utils/dimensions.dart';
import '../Firebase/FirebaseStorageService.dart';
import '../Utils/AppConstents.dart';
import '../Utils/Colors.dart';
import '../Utils/Toast.dart';

class EditProfileScreen extends StatefulWidget {
  // Defining a stateful widget EditProfileScreen that extends StatefulWidget. The widget takes no required parameters.
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
//   Defining the _EditProfileScreenState class, which extends the State class for managing the state of the widget.
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  // Inside the state class, two variables _screenWidth and _screenHeight are declared, and they are assigned the width and height of the device screen using MediaQuery.

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  // TextEditingController instances:
  // Four TextEditingController instances are declared: _userNameController, _firstNameController, _phoneNumberController, and _dobController. These controllers are used to manage the text entered by the user in different input fields.

  final GlobalKey<FormState> _userFormKey = GlobalKey<FormState>();

  // GlobalKey<FormState>:
  // The _userFormKey is a GlobalKey of type FormState used to control and interact with a Form widget. It allows validating and managing the form fields within the form.

  bool buttonLoading = false;

  XFile? selectedFile;

  UserObject? userData;
  FullUserObject? fullUserData;

  // Other variables:
  //
  // buttonLoading is a boolean variable used to manage the state of a button, similar to what we discussed in the previous examples.
  // XFile? selectedFile is likely used to store an image file selected by the user. The XFile type is part of the image_picker package in Flutter.

  // User data:
  //
  // UserObject? userData and FullUserObject? fullUserData are objects representing user data. FullUserObject seems to contain more detailed user information, while UserObject may be a simpler version with fewer details.

  Future<void> getUserData() async {
    await FirebaseDatabaseHelper().getUsers().then((user) {
      if (user != null) {
        setState(() {
          userData = user;
        });
        _userNameController.text = user.userName;
        _phoneNumberController.text = user.phoneNumber;
      }
    });
  }

  Future<void> getFullUserData() async {
    await FirebaseDatabaseHelper().getFullUsers().then((user) {
      if (user != null) {
        setState(() {
          fullUserData = user;
        });
        _userNameController.text = user.userName!;
        _firstNameController.text = user.firstName!;
        _phoneNumberController.text = user.phoneNumber!;
        _dobController.text = user.dob!;
      } else {
        getUserData();
      }
    });
  }
  //
  // getUserData() and getFullUserData() methods:
  // These methods are used to retrieve user data from a database using the FirebaseDatabaseHelper class.

  @override
  void initState() {
    getFullUserData();
    super.initState();

    //   initState() method:
    // The initState() method is a lifecycle method in Flutter that is called when the widget is inserted into the widget tree. In this implementation, getFullUserData() is called in initState() to fetch the full user data as soon as the widget is inserted into the tree.
  }

  @override
  // @override:
  // This is an annotation in Dart indicating that the method being declared (build in this case) is intended to override a method from its superclass. In this case, it overrides the build method from the StatefulWidget or StatelessWidget class.
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold widget:
      // The Scaffold widget provides a basic structure for a material design-based screen in Flutter. It typically includes an app bar, a body area, and optional floating action buttons, bottom navigation, and other common elements.
      body: SafeArea(
        // body property:
        // The body property of the Scaffold is set to a SafeArea widget. The SafeArea widget ensures that the content is displayed within the safe area of the device, avoiding any notches, status bars, or other device-specific elements that may overlap the UI.
        child: _bodyView(),
        //   _bodyView():
        // The SafeArea widget has a single child, _bodyView(). The _bodyView() method is a custom method that returns a widget representing the main body content of the screen. It is likely where the main UI content of the application is defined.
      ),
    );
  }

  Widget _bodyView() {
    return Stack(
      // Stack:
      // The main container is wrapped in a Stack widget. The Stack allows stacking multiple widgets on top of each other.
      alignment: Alignment.center,
      //e Stack allows widgets to be stacked on top of each other, and alignment: Alignment.center centers its children within the Stack.
      //
      // dart
      children: [
        Container(
          // Main Content Container:
          // The main container holds the profile editing content. It has a background color, padding, and contains a Form widget as its child.
          height: _screenHeight,
          width: _screenWidth,
          // Here, a Container is used as the main content container. It has a fixed height and width based on _screenHeight and _screenWidth variables. It also has some padding applied to its content, and a background color specified by AppThemeColor.backGroundColor.
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          decoration: const BoxDecoration(
            color: AppThemeColor.backGroundColor,
          ),
          child: Form(
            key: _userFormKey,
            child: Column(
              children: [
                AppConstents().topBarViewWithBack(context: context),
                // AppConstents().topBarViewWithBack(context: context):
                // This widget represents the top bar view with a back button. It is created using a custom widget defined in the AppConstents class, which presumably provides consistent UI components throughout the application. The context parameter is passed to the topBarViewWithBack method, likely to allow the back button to navigate to the previous screen when tapped.
                const SizedBox(
                  height: 40,
                  //const SizedBox(height: 40):
                  // This widget represents an empty space with a height of 40 logical pixels. It is used as a vertical spacer between the top bar view and the rest of the content. It creates a gap of 40 pixels between the top bar and the user profile editing content.
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // pickFile();
                            // ImagePicker.platform.getImage(source: ImageSource.gallery):
                            // This line opens an image picker dialog, allowing the user to select an image from their device's gallery (photo library). The ImagePicker is a Flutter plugin that simplifies working with the device's camera and image gallery.
                            ImagePicker.platform
                                .getImage(source: ImageSource.gallery)
                                .then((mediaInfo) {
                              //     .then((mediaInfo) { ... }):
                              // The .then() function is used to handle the result of the image picker operation asynchronously. When the user selects an image or cancels the image picker dialog, the then block will be executed.
                              setState(() {
                                selectedFile = mediaInfo;
                              });
                              //   setState(() { selectedFile = mediaInfo; });:
                              // Inside the then block, the setState() function is called to update the state of the widget. In this case, the selectedFile variable is updated with the information of the selected image (media). selectedFile is likely a variable that holds information about the selected image file (e.g., the path or file object).
                            });
                          },
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                // Container(...):
                                // The first child of the Stack is a Container widget that displays the profile picture. It has a fixed width and height (_screenWidth / 3.5), making it a square. The decoration property is used to define the appearance of the container, including its background image. The profile picture is represented by a DecorationImage.
                                //
                                // If selectedFile is not null, it means the user has selected an image from the gallery (using the image picker), and the selected image is displayed using FileImage to read the image from the selected file.
                                // If fullUserData is not null, it means the user's profile already has a profile picture link (imageLink), and it is displayed using NetworkImage to load the image from the provided URL.
                                // If both selectedFile and fullUserData are null, meaning no image is selected and no profile picture link is available, a default profile picture ('images/profile.png') is displayed using AssetImage.
                                width: _screenWidth / 3.5,
                                height: _screenWidth / 3.5,
                                decoration: BoxDecoration(
                                  // color: Colors.purple,
                                  borderRadius:
                                      BorderRadius.circular(_screenWidth / 3.5),
                                  image: selectedFile != null
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(
                                            File(selectedFile!.path),
                                          ),
                                        )
                                      : fullUserData != null
                                          ? DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                fullUserData!.imageLink!,
                                              ),
                                            )
                                          : const DecorationImage(
                                              image: AssetImage(
                                                'images/profile.png',
                                              ),
                                            ),
                                ),
                              ),
                              Container(
                                // Container(...):
                                // The second child of the Stack is another Container widget that displays an edit icon on the profile picture. It is aligned at the bottom right corner of the profile picture (Alignment.bottomRight). The container has a circular shape with a border radius of 5 to create a circular background for the icon. The icon itself is a white-colored pencil-shaped edit icon (Icons.edit_outlined) with a size of 17 pixels.
                                //
                                // The overall effect of this code is to display the user's profile picture (either from the selected image, profile picture link, or a default image) with an edit icon placed at the bottom right corner. When the user taps on the profile picture (as the GestureDetector wraps this Stack), the image picker dialog is triggered for the user to select a new image, and the profile picture is updated accordingly.
                                decoration: BoxDecoration(
                                  color: AppThemeColor.pureBlackColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.all(5),
                                child: const Icon(
                                  Icons.edit_outlined,
                                  color: AppThemeColor.pureWhiteColor,
                                  size: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          // Column(...):
                          // The Column widget is used to organize the child widgets in a vertical arrangement. It has crossAxisAlignment: CrossAxisAlignment.start, which aligns its children to the start (left) edge of the column.
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 50,
                              //   const SizedBox(height: 50),:
                              // This adds an empty space (vertical spacer) with a height of 50 logical pixels between the top of the column and the first content (profile picture).
                            ),
                            Container(
                              // Container(...):
                              // This container wraps the widget for editing the username. It has a white background (AppThemeColor.pureWhiteColor), padding, and margin to add some space around its content. It contains a Row widget with an Icon representing the person icon (Icons.person) in blue color (AppThemeColor.darkBlueColor) and size 22. It is followed by a SizedBox with width 15 to create some space between the icon and the Expanded widget, which contains a TextFormField. The TextFormField is for entering the username (_userNameController). It has a hint text "username" (hintText: 'username') and a validator function that checks if the value entered has a length greater than 1, otherwise, it displays the error message "User Name!".
                              decoration: const BoxDecoration(
                                color: AppThemeColor.pureWhiteColor,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: AppThemeColor.darkBlueColor,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                    //   const SizedBox(height: 15),:
                                    // Another empty space (vertical spacer) with a height of 15 logical pixels to separate the username field from the next field.
                                  ),
                                  Expanded(
                                    // Expanded:
                                    // The Expanded widget is used to make the TextFormField take up all the available remaining vertical space within its parent. It allows the TextFormField to expand and fill the available space in the Column (or Row) containing it. It ensures that the input field takes up as much space as possible without overflowing.
                                    child: TextFormField(
                                      // TextFormField:
                                      // The TextFormField widget is used to create a text input field that allows the user to enter and edit text. It has several properties:

                                      // controller: _userNameController: This property binds a TextEditingController to the TextFormField. The _userNameController is responsible for managing the text value of this input field.

                                      controller: _userNameController,
                                      decoration: const InputDecoration(
                                          // decoration: const InputDecoration(hintText: 'username'): This property defines the appearance of the input field. In this case, it provides a hint text "username" that appears inside the input field when it is empty and not focused.
                                          hintText: 'username'),
                                      validator: (value) => value!.length > 1
                                          // validator: (value) => value!.length > 1 ? null : 'User Name!': This property specifies a validation function for the input field. The function takes the current input value as value. It checks if the length of the value is greater than 1. If it is, the input is considered valid, and null is returned. Otherwise, the function returns the error message 'User Name!', indicating that the input is invalid.

                                          ? null
                                          : 'User Name!',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                              //   const SizedBox is a widget in Flutter that creates a box with a fixed height and width. It is typically used to add spacing between other widgets. The SizedBox has a height property that determines its height, and the width property (not used in this case) can determine its width.
                            ),
                            Container(
                              // Container:
                              // The Container is used to wrap the entire row layout. It has a decoration property that sets the background color of the container to AppThemeColor.pureWhiteColor. This gives the container a white background.
                              decoration: const BoxDecoration(
                                color: AppThemeColor.pureWhiteColor,
                              ),
                              // padding and margin properties:
                              // The padding property sets the horizontal padding inside the container to 10 logical pixels on both sides. The margin property adds horizontal margins of 15 logical pixels on both sides of the container. These properties create some space around the content inside the container and also control the spacing between this container and its neighboring widgets.
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                // Row:
                                // Inside the Container, there is a Row widget. The Row allows its children to be arranged in a horizontal line.
                                children: [
                                  const Icon(
                                    // Icon:
                                    // The Row starts with an Icon widget, which displays the "label" icon (Icons.label). The icon has a color of AppThemeColor.darkBlueColor (presumably blue) and a size of 22 logical pixels.
                                    Icons.label,
                                    color: AppThemeColor.darkBlueColor,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    // SizedBox:
                                    // After the icon, there is a SizedBox with a width of 15 logical pixels. This adds some spacing between the icon and the TextFormField.
                                    width: 15,
                                  ),
                                  Expanded(
                                    // Expanded:
                                    // The Expanded widget takes up all the available horizontal space within the Row. It ensures that the TextFormField expands to fill the remaining space after accommodating the Icon and the SizedBox.
                                    child: TextFormField(
                                      // TextFormField:
                                      // The TextFormField is used to capture the user's input for the first name. It has several properties:
                                      controller: _firstNameController,
                                      // controller: _firstNameController: This property binds a TextEditingController to the TextFormField. The _firstNameController is responsible for managing the text value entered in this input field.

                                      decoration: const InputDecoration(
                                          hintText: 'First name'),
                                      validator: (value) => value!.length > 1
                                          // validator: (value) => value!.length > 1 ? null : 'First Name!': This property specifies a validation function for the input field. The function takes the current input value as value. It checks if the length of the value is greater than 1. If it is, the input is considered valid, and null is returned. Otherwise, the function returns the error message 'First Name!', indicating that the input is invalid.

                                          // The validator function is typically used with a Form widget to validate form fields when the form is submitted. If the validator function returns a non-null value, it means the field is invalid, and the error message will be displayed.

                                          ? null
                                          : 'First Name!',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                              // SizedBox:
                              // After the icon, there is a SizedBox with a width of 15 logical pixels. This adds some spacing between the icon and the TextFormField.
                            ),
                            Container(
                              // Container:
                              // The Container wraps the entire row layout. It has a decoration property that sets the background color of the container to AppThemeColor.pureWhiteColor, which gives the container a white background.
                              decoration: const BoxDecoration(
                                color: AppThemeColor.pureWhiteColor,
                              ),
                              // padding and margin properties:
                              // The padding property sets the horizontal padding inside the container to 10 logical pixels on both sides. The margin property adds horizontal margins of 15 logical pixels on both sides of the container. These properties create some space around the content inside the container and also control the spacing between this container and its neighboring widgets.
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                // Row:
                                // Inside the Container, there is a Row widget. The Row allows its children to be arranged in a horizontal line.
                                children: [
                                  const Icon(
                                    // Icon:
                                    // The Row starts with an Icon widget displaying the "calendar_month_rounded" icon (Icons.calendar_month_rounded). The icon has a color of AppThemeColor.darkBlueColor (presumably blue) and a size of 22 logical pixels.
                                    Icons.calendar_month_rounded,
                                    color: AppThemeColor.darkBlueColor,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    // SizedBox:
                                    // After the icon, there is another SizedBox with a width of 15 logical pixels. This adds some spacing between the icon and the TextFormField.
                                    width: 15,
                                  ),
                                  Expanded(
                                    // Expanded:
                                    // The Expanded widget takes up all the available horizontal space within the Row. It ensures that the TextFormField expands to fill the remaining space after accommodating the Icon and the SizedBox.
                                    child: TextFormField(
                                      // TextFormField:
                                      // The TextFormField is used to capture the user's input for the date of birth. It has several properties:

                                      controller: _dobController,
                                      // controller: _dobController: This property binds a TextEditingController to the TextFormField. The _dobController is responsible for managing the text value entered in this input field.

                                      validator: (value) => value!.length > 1
                                          // validator: (value) => value!.length > 1 ? null : 'Date of birth26 Dece': This property specifies a validation function for the input field. The function takes the current input value as value. It checks if the length of the value is greater than 1. If it is, the input is considered valid, and null is returned. Otherwise, the function returns the error message 'Date of birth26 Dece', indicating that the input is invalid.

                                          ? null
                                          : 'Date of birth26 Dece',
                                      decoration: const InputDecoration(
                                          // decoration: const InputDecoration(hintText: 'Date of birth'): This property defines the appearance of the input field. In this case, it provides a hint text "Date of birth" that appears inside the input field when it is empty and not focused.

                                          hintText: 'Date of birth'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                              //   SizedBox:
                              // This creates a vertical spacer with a height of 15 logical pixels, adding some space between the previous content and the phone number input field.
                            ),
                            Container(
                              // Container:
                              // This container wraps the phone number input field and its associated icon. It has padding and margin properties to control the spacing around the content inside it.

                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                // Row:
                                // The Row widget allows its children to be arranged in a horizontal line.
                                children: [
                                  const Icon(
                                    // Icon:
                                    // The Row starts with an Icon widget displaying the "phone_android" icon (Icons.phone_android). The icon has a color of AppThemeColor.darkBlueColor (presumably blue) and a size of 22 logical pixels.
                                    Icons.phone_android,
                                    color: AppThemeColor.darkBlueColor,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    // SizedBox:
                                    // After the icon, there is another SizedBox with a width of 15 logical pixels. This adds some spacing between the icon and the TextFormField.

                                    width: 15,
                                  ),
                                  Expanded(
                                    // Expanded:
                                    // The Expanded widget takes up three parts (flex: 3) of the available horizontal space within the Row. It ensures that the TextFormField expands to fill the remaining space after accommodating the Icon and the SizedBox.
                                    flex: 3,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: AppThemeColor.pureWhiteColor,
                                      ),
                                      child: TextFormField(
                                        controller: _phoneNumberController,
                                        validator: (value) => value!.length > 1
                                            ? null
                                            : 'Phone number!',
                                        decoration: const InputDecoration(
                                            hintText: '413525565'),
                                        //   TextFormField:
                                        // The TextFormField is used to capture the user's input for the phone number. It has several properties:
                                        //
                                        // controller: _phoneNumberController: This property binds a TextEditingController to the TextFormField. The _phoneNumberController is responsible for managing the text value entered in this input field.
                                        //
                                        // validator: (value) => value!.length > 1 ? null : 'Phone number!': This property specifies a validation function for the input field. The function takes the current input value as value. It checks if the length of the value is greater than 1. If it is, the input is considered valid, and null is returned. Otherwise, the function returns the error message 'Phone number!', indicating that the input is invalid.
                                        //
                                        // decoration: const InputDecoration(hintText: '413525565'): This property defines the appearance of the input field. In this case, it provides a hint text "413525565" that appears inside the input field when it is empty and not focused.
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 100,
                              //   SizedBox:
                              // This creates a vertical spacer with a height of 100 logical pixels, adding some space between the phone number input field and the "Update" button.
                            ),
                            Center(
                              // Center:
                              // The Center widget centers its child horizontally within it.
                              child: InkWell(
                                onTap: () => fullUserData != null
                                    ? updateFullCustomer()
                                    : addNewFullCustomer(),
                                // InkWell:
                                // The InkWell wraps the "Update" button. It allows the button to have a touch ripple effect when tapped.

                                // onTap:
                                // The onTap property of InkWell is set to a callback function. If the user taps on the "Update" button, the function updateFullCustomer() will be called if fullUserData is not null; otherwise, addNewFullCustomer() will be called.
                                child: Container(
                                  // Container:
                                  // This container represents the "Update" button. It has a fixed width of 150 logical pixels and padding on the vertical axis. It has a blue background color (AppThemeColor.darkBlueColor) and rounded borders (BorderRadius.circular(4)).
                                  width: 150,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppThemeColor.darkBlueColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    // Text:
                                    // Inside the "Update" button container, there is a Text widget displaying the text "Update". The text has a white color (AppThemeColor.pureWhiteColor).
                                    'Update',
                                    style: TextStyle(
                                      color: AppThemeColor.pureWhiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              // SizedBox:
                              // This creates a vertical spacer with a height of 100 logical pixels, adding some space after the "Update" button.
                              height: 100,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        buttonLoading
            // buttonLoading: This is a boolean variable that determines whether the loading view should be displayed (true) or not (false).
            ? AppConstents().loaderView(
                // Ternary Operator (? :): The ternary operator is a shorthand way to write an if-else statement. If the condition (buttonLoading) is true, the expression before the ? is executed; otherwise, the expression after the : is executed.
                message: 'Updating Profile!',
                image: 'images/loading.png',
                width: _screenWidth,
                height: 110,
                // AppConstents().loaderView(...): If buttonLoading is true, the loaderView method from the AppConstents class is called. It displays a loader view with a loading message and an image (loading.png). The width of the loader view is _screenWidth, and the height is 110 logical pixels.
              )
            : const SizedBox()
        //   const SizedBox(): If buttonLoading is false, an empty SizedBox is returned. This is used as a placeholder, effectively hiding any content that would be displayed when buttonLoading is false.
      ],
    );
  }

  Widget _singleTabView({
    required IconData iconData,
    // iconData (required IconData): This parameter represents the icon to be displayed on the left side of the tab. It's required, so you must provide an IconData value when calling this function.
    required String title,
    //   title (required String): This parameter represents the title or text to be displayed next to the icon. It's also required, so you must provide a non-empty string when calling this function.
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        // Inside the Row, there are two main children arranged using MainAxisAlignment.spaceBetween. This alignment property ensures that the first child (icon and title) is aligned to the start, and the second child (right arrow icon) is aligned to the end of the row, creating some space between them.
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            // The function returns a Container widget that contains a Row widget as its child. The Row widget arranges its children horizontally.
            // Inside the Row, there are two main children arranged using MainAxisAlignment.spaceBetween. This alignment property ensures that the first child (icon and title) is aligned to the start, and the second child (right arrow icon) is aligned to the end of the row, creating some space between them.
            children: [
              Icon(
                iconData,
                size: 22,
              ),
              // Icon widget: Displays the specified iconData with a size of 22 logical pixels.
              const SizedBox(
                width: 15,
              ),
              // SizedBox: A fixed-width box with a width of 15 logical pixels, creating space between the icon and the title.
              Text(
                title,
                style: const TextStyle(
                  color: AppThemeColor.pureBlackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: Dimensions.fontSizeLarge,
                ),
              )
              //   Text widget: Displays the specified title with the specified style. The style includes a black color, normal font weight (FontWeight.w400), and a font size defined by Dimensions.fontSizeLarge.
            ],
          ),
          const Icon(
            Icons.keyboard_arrow_right_rounded,
            color: AppThemeColor.pureBlackColor,
            size: 28,
          )
          //   The second child of the row is an Icon widget that displays the right arrow icon (Icons.keyboard_arrow_right_rounded) with a size of 28 logical pixels and a black color (AppThemeColor.pureBlackColor).
        ],
      ),
    );
  }

  // when user edit first time it will call
  Future<void> addNewFullCustomer() async {
    try {
      // The try block is used to catch any potential errors that might occur during the execution of the function.
      if (!buttonLoading) {
        // The first if condition if (!buttonLoading) checks if the buttonLoading flag is false. This flag is used to prevent multiple simultaneous updates. If the button is not in a loading state, the function proceeds.
        if (_userFormKey.currentState!.validate()) {
          // The next if condition checks if the form is valid by calling _userFormKey.currentState!.validate(). This will trigger the validation for each TextFormField within the form. If the form is valid, it continues to the next step.
          if (selectedFile != null) {
            // Inside the valid form block, there is another if condition that checks if a profile image has been selected (selectedFile != null). If an image is selected, it continues with the user creation process.
            _userFormKey.currentState!.save();
            // _userFormKey.currentState!.save(); saves the current state of the form, updating the controllers with the entered values.
            setState(() {
              // setState(() { buttonLoading = true; }); sets the buttonLoading flag to true, indicating that the update process is starting. This will cause the UI to display a loading indicator.
              buttonLoading = true;
            });
            FullUserObject userObject = FullUserObject(
              // A new FullUserObject named userObject is created, and it is populated with the data entered by the user in the form fields (_firstNameController.text, _userNameController.text, _dobController.text, and _phoneNumberController.text).
              firstName: _firstNameController.text,
              userName: _userNameController.text,
              dob: _dobController.text,
              phoneNumber: _phoneNumberController.text,
            );
            if (selectedFile != null) {
              // If a profile image was selected, userObject.imageFile is set to the selected image (selectedFile).
              userObject.imageFile = selectedFile;
            }

            addUserToFirebaseToFirebase(user: userObject);
            //   The function addUserToFirebaseToFirebase is called, passing the userObject as an argument. This function will handle the actual process of uploading the image to Firebase Storage and updating the user data in the Realtime Database.
          } else {
            ShowToast().showNormalToast(msg: 'Please Select Profile Image!');
            //   If no profile image is selected, the user is notified to select a profile image using ShowToast().showNormalToast(msg: 'Please Select Profile Image!');.
          }
        }
      } else {
        ShowToast().showNormalToast(msg: 'Please Wait!');
        //   If the form is not valid, the user is notified to wait using ShowToast().showNormalToast(msg: 'Please Wait!');.
      }
    } on PlatformException catch (e) {
      ShowToast().showNormalToast(msg: e.message!);
      //   In case of any PlatformException, it shows a message containing the error using ShowToast().showNormalToast(msg: e.message!);.
    } catch (e) {
      ShowToast().showNormalToast(
          msg:
              'The connection failed because the device is not connected to the internet');
      //   In case of any other error, it shows a message indicating a possible connection issue using ShowToast().showNormalToast(msg: 'The connection failed because the device is not connected to the internet');.
    } finally {
      // setState(() {
      //   buttonLoading = false;
      // });

      //   The finally block is commented out. Typically, this block would be used to clean up resources or execute code that should always run, regardless of whether an exception occurs or not. In this case, it is not being used.
    }
  }

// when user edit first time it will call
  Future<FullUserObject?> addUserToFirebaseToFirebase(
      {required FullUserObject user}) async {
    // The function is marked as async since it performs asynchronous operations.
    DatabaseReference dbf = FirebaseDatabase.instance.ref();
    FullUserObject updatedUser = user;
    // The function takes a FullUserObject named user as an argument, which contains the user's profile information, including the selected profile image.
    // A reference to the Firebase Realtime Database is created using DatabaseReference dbf = FirebaseDatabase.instance.ref();.
    try {
      String userId = userData!.uid;
      // The userId is extracted from userData, which seems to be an instance of a user model containing the user's unique identifier (uid).
      String userImageName = '$userId.${user.imageFile!.name.split('.').last}';
      // A copy of the input user is created and assigned to FullUserObject updatedUser = user;. This copy will be used to update the user's information after the image upload is complete.
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('ProfileImages')
          .child(userImageName);
      // The userImageName is generated using the user's userId and the file extension of the selected profile image. It will be used as the name of the image file in Firebase Storage.
      await FirebaseStorageService()
          // A reference to the Firebase Storage location for the profile image is created using Reference ref = FirebaseStorage.instance.ref().child('ProfileImages').child(userImageName);.
          .uploadImage(file: user.imageFile!, ref: ref)
          .then((uploadTask) async {
        //     The FirebaseStorageService().uploadImage method is called to upload the user's profile image to the Firebase Storage location referenced by ref. This method seems to return an UploadTask?.
        if (uploadTask != null) {
          await uploadTask.whenComplete(() async {
            await ref.getDownloadURL().then((imageLink) async {
              // An await is used to wait for the completion of the image upload task. The uploadTask contains information about the status and progress of the image upload.
              print('upload done $imageLink');
              updatedUser.uid = userId;
              updatedUser.imageLink = imageLink;
              updatedUser.imageName = userImageName;
              print(uploadTask.snapshot.bytesTransferred);
              // If uploadTask is not null (i.e., the image upload was successful), the function continues.
              //
              // Inside the uploadTask.whenComplete block, the image's download URL (imageLink) is obtained from the Firebase Storage reference (ref). This URL will be used to display the user's profile image.
              await dbf
                  .child('FullUserProfiles')
                  .child(userId)
                  .set(
                    updatedUser.toJson(),
                  )
                  // The updatedUser object's uid, imageLink, and imageName properties are updated with the relevant values. The uid is set to userId, and imageLink is set to imageLink. imageName is set to the userImageName.
                  .then((value) {
                setState(() {
                  buttonLoading = false;
                  //   After the user's information is successfully updated in the database, setState(() { buttonLoading = false; }); is called to set buttonLoading to false and update the UI.
                });

                Navigator.pop(context);
              });
            });
          });
        } else {
          return null;
        }
      });
      return updatedUser;
    } catch (e) {
      setState(() {
        buttonLoading = false;
        //   If any exceptions occur during the process, the function catches them in the catch (e) block. It sets buttonLoading to false and prints the error message.
      });
      print("Add New Full User Error");
      print(e);
      return null;
    } finally {
      // The finally block sets buttonLoading to false, ensuring that it is reset even if an exception occurs.
      setState(() {
        buttonLoading = false;
      });
    }
  }

  // when user edit second or more we just update their existing profile
  Future<void> updateFullCustomer() async {
    // The function is marked as async since it performs asynchronous operations.
    try {
      if (!buttonLoading) {
        if (_userFormKey.currentState!.validate()) {
          // The function does the necessary validation using _userFormKey.currentState!.validate() to ensure that the user has provided valid information in the form fields.
          _userFormKey.currentState!.save();
          // If the validation is successful, the function proceeds to update the user's profile.
          // The function first saves the current form state using _userFormKey.currentState!.save();. This ensures that the latest data entered by the user is captured.
          setState(() {
            buttonLoading = true;
            // he buttonLoading state is set to true using setState(() { buttonLoading = true; });. This activates the loading state to indicate that the profile update is in progress.
            print('loader $buttonLoading');
          });
          FullUserObject userObject = FullUserObject(
            uid: fullUserData!.uid!,
            firstName: _firstNameController.text,
            userName: _userNameController.text,
            dob: _dobController.text,
            phoneNumber: _phoneNumberController.text,
          );
          // A new FullUserObject named userObject is created with the updated profile information. The uid is set to the current user's uid, and the other properties are updated with the values entered by the user in the form fields.
          // If a new profile image is selected (selectedFile != null), the imageFile property of userObject is updated with the selected image. Otherwise, if no new image is selected, the existing imageLink from the fullUserData object is assigned to the userObject.
          if (selectedFile != null) {
            userObject.imageFile = selectedFile;
          } else {
            userObject.imageLink = fullUserData!.imageLink;
          }
          // If buttonLoading is already true (i.e., an update is already in progress), the function displays a toast message to inform the user to wait for the current update to complete.

          updateUserToFirebaseToFirebase(user: userObject);
          //   The updateUserToFirebaseToFirebase function is called with the userObject as an argument to update the user's profile information in Firebase.
        }
      } else {
        ShowToast().showNormalToast(msg: 'Please Wait!');
      }
    } on PlatformException catch (e) {
      ShowToast().showNormalToast(msg: e.message!);
    } catch (e) {
      ShowToast().showNormalToast(
          msg:
              'The connection failed because the device is not connected to the internet');
    } finally {
      // setState(() {
      //   buttonLoading = false;
      // });
    }
  }

// when user edit second or more we just update their existing profile
  Future<FullUserObject?> updateUserToFirebaseToFirebase(
      {required FullUserObject user}) async {
    // The function is marked as async since it performs asynchronous operations.
    DatabaseReference dbf = FirebaseDatabase.instance.ref();
    FullUserObject updatedUser = user;
    // The function receives a FullUserObject named user as an argument, which contains the updated profile information.
    // A new DatabaseReference named dbf is created to access the Firebase Realtime Database.
    try {
      String userId = user.uid!;
      // A new FullUserObject named updatedUser is created, initialized with the provided user data. This object will be used to track the updated user information.
      if (user.imageFile != null) {
        // If a new imageFile is provided, a userImageName is generated using the userId and the file extension of the selected image. This name will be used to store the user's profile image in Firebase Storage.
        String userImageName =
            '$userId.${user.imageFile!.name.split('.').last}';
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('ProfileImages')
            .child(userImageName);
        // A new Reference named ref is created to point to the location in Firebase Storage where the new profile image will be stored.
        await FirebaseStorageService()
            .uploadImage(file: user.imageFile!, ref: ref)
            .then((uploadTask) async {
          //     The uploadImage function from FirebaseStorageService is called to upload the new image to Firebase Storage. This function returns an uploadTask which represents the upload process.
          if (uploadTask != null) {
            // If the uploadTask is not null, it means the upload was successful. The function waits for the upload to complete using await uploadTask.whenComplete(...).
            //
            // Once the upload is complete, the function retrieves the download URL of the newly uploaded image using ref.getDownloadURL().
            await uploadTask.whenComplete(() async {
              await ref.getDownloadURL().then((imageLink) async {
                print('upload done $imageLink');
                updatedUser.uid = userId;
                updatedUser.imageLink = imageLink;
                updatedUser.imageName = userImageName;
                print(uploadTask.snapshot.bytesTransferred);
                // The imageLink, imageName, and uid properties of the updatedUser object are updated with the newly generated image URL, the userImageName, and the userId, respectively.
                await dbf
                    .child('FullUserProfiles')
                    .child(userId)
                    .update(
                      updatedUser.toJson(),
                    )
                    .then((value) {
                  //     The user's profile information is updated in the Firebase Realtime Database using dbf.child('FullUserProfiles').child(userId).update(updatedUser.toJson()).
                  // If the user did not provide a new imageFile, the function proceeds to update the user's profile information in the Firebase Realtime Database directly without uploading a new image.
                  setState(() {
                    buttonLoading = false;
                    //   If the update is successful (whether with or without a new image), buttonLoading is set to false using setState(() { buttonLoading = false; }); to deactivate the loading state.
                  });

                  Navigator.pop(context);
                });
              });
            });
          } else {
            return null;
          }
        });
      } else {
        await dbf
            .child('FullUserProfiles')
            .child(userId)
            .update(
              updatedUser.toJson(),
            )
            .then((value) {
          setState(() {
            buttonLoading = false;
          });

          Navigator.pop(context);
        });
      }

      return updatedUser;
    } catch (e) {
      setState(() {
        buttonLoading = false;
      });

      print("Update Full User Error");
      print(e);
      return null;
    } finally {
      // Finally, the Navigator.pop(context) is called to close the current screen and navigate back to the previous screen after the profile is updated.
      setState(() {
        buttonLoading = false;
        //   In the finally block, buttonLoading is set to false. This ensures that the loading state is deactivated regardless of whether the update was successful or if any errors occurred.
      });
    }
  }
}
