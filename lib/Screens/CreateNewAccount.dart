import 'package:firebase_auth/firebase_auth.dart';
// Custom utility file for Firebase Authentication.
import 'package:flutter/material.dart';
// Flutter Material package for widgets and UI components.
import 'package:partner/Utils/Colors.dart';
// Custom utility file for application colors.
import 'package:partner/Utils/Router.dart';
// Custom utility file for Router usage.
import 'package:partner/Utils/Toast.dart';
// Custom utility file for Toast usage.
import 'package:partner/Utils/dimensions.dart';
// Custom utility file for application dimensions.
import '../Utils/AppConstents.dart';
// Custom utility file for application constants.

class CreateNewAccount extends StatefulWidget {
  // Defining a stateful widget CreateNewAccount that extends StatefulWidget. The widget takes no required parameters.

  const CreateNewAccount({super.key});

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
//   Defining the _CreateNewAccountState class, which extends the State class for managing the state of the widget.
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  // Inside the state class, two variables _screenWidth and _screenHeight are declared, and they are assigned the width and height of the device screen using MediaQuery.

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // GlobalKey is a Flutter class that is used to uniquely identify and reference widgets across different parts of the application. In this case, the GlobalKey is being used to reference a FormState object.
  // FormState is a class that represents the state of a Form widget. A Form is a container for form fields in a Flutter application, and FormState is used to interact with and manage the state of the form, such as validating its fields and saving their values.
  // Using a GlobalKey in this context allows you to interact with the form from other parts of your code, such as validating the form or resetting it. The GlobalKey ensures that you can access the same form state from anywhere in the widget tree.

  TextEditingController userNameController = TextEditingController();
  // userNameController is an instance of TextEditingController used to control the text input for the username.
  TextEditingController passwordController = TextEditingController();
  // passwordController is an instance of TextEditingController used to control the text input for the password.
  TextEditingController codeController = TextEditingController();
  // codeController is an instance of TextEditingController used to control the text input for some code, possibly a verification code or any other specific code input.
  TextEditingController numberController = TextEditingController();
  // numberController is an instance of TextEditingController used to control the text input for a number, such as a phone number or any other numeric input.
  bool buttonLoading = false;

  @override
  Widget build(BuildContext context) {
    // Widget build(BuildContext context): This is an overridden method from the State class and is called whenever the widget needs to be rebuilt. It returns the UI for the widget.
    return Scaffold(
      // return Scaffold(body: _bodyView());: In the build method, you are returning a Scaffold widget with the _bodyView() method as its body. The Scaffold widget is a basic structure for implementing Material Design layouts in Flutter apps. The _bodyView() method, which is not shown in the provided code, is expected to return a widget that will be displayed as the main content of the Scaffold.
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    // _bodyView Widget:
    // This widget seems to represent the body of a screen or a page in a Flutter application. It uses a Stack widget to place its children on top of each other. The alignment property of the Stack is set to Alignment.center, which means its children will be centered within the Stack.
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            width: _screenWidth,
            height: _screenHeight,
            color: AppThemeColor.backGroundColor,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                // Form Widget:
                // Inside the Stack, there's a Container with a background color and some padding. This Container wraps a SingleChildScrollView to provide scrolling capability when the content overflows the screen. Inside the SingleChildScrollView, there's a Form widget with a GlobalKey named _formKey. The Form widget is used to handle form fields and their validation.
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('images/inAppIcon.png'),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create Your ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppThemeColor.pureBlackColor,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          'Account',
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
                        const Text(
                          'Username',
                          style: TextStyle(
                            color: AppThemeColor.pureBlackColor,
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppThemeColor.pureWhiteColor,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: AppThemeColor.darkBlueColor,
                                size: 22,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: userNameController,
                                  decoration: const InputDecoration(
                                      hintText: 'username'),
                                  validator: (value) => value!.length > 1
                                      ? null
                                      : 'User name is missing',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Phone Number',
                          style: TextStyle(
                            color: AppThemeColor.pureBlackColor,
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          // User Input Fields:
                          // Within the Form, there are several input fields for creating a new account. These fields are for the username, phone number (with country code), and password. Each input field uses a TextEditingController to control its behavior, and the values entered by the user are stored in the respective controller variables (userNameController, codeController, numberController, passwordController).
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: AppThemeColor.pureWhiteColor,
                                ),
                                child: TextFormField(
                                  controller: codeController, //The controller allows you to interact with the text entered in the field, read its value, or set its value programmatically.
                                  keyboardType: TextInputType.phone,
                                  decoration:
                                      const InputDecoration(hintText: '+61'),
                                  // The validator property is a callback function that is executed to perform form validation on the input value of the TextFormField.
                                  // It takes the input value as an argument and returns an error message  if the value is not valid. If the input is valid, the function should return null.
                                  validator: (value) => value!.length > 1
                                      ? null
                                      : 'Country code!',
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
                                child: TextFormField(
                                  controller: numberController, //The controller allows you to interact with the text entered in the field, read its value, or set its value programmatically.
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                      hintText: '413525565'),
                                  validator: (value) => value!.length > 1
                                      ? null
                                      : 'Phone number is missing',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Password',
                          style: TextStyle(
                            color: AppThemeColor.pureBlackColor,
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppThemeColor.pureWhiteColor,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.lock,
                                color: AppThemeColor.darkBlueColor,
                                size: 22,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: passwordController,
                                  decoration: const InputDecoration(
                                      hintText: 'Password'),
                                  // The validator property is a callback function that is executed to perform form validation on the input value of the TextFormField.
                                  // It takes the input value as an argument and returns an error message  if the value is not valid. If the input is valid, the function should return null.
                                  validator: (value) => value!.length > 7
                                      ? null
                                      : 'Password length must be 8 digits',
                                ),
                              ),
                              const Icon(
                                Icons.remove_red_eye,
                                color: AppThemeColor.darkBlueColor,
                                size: 22,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          // Signup Button:
                          // Below the input fields, there is a "Signup" button created using the InkWell widget.
                          child: InkWell(
                            //The onTap callback of the InkWell is set to _signUpCalled(), which is a method that handles the signup process. When the button is tapped, the _signUpCalled method is called.
                            onTap: () => _signUpCalled(),
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
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              'Already have an Account?',
                              style: TextStyle(
                                color: AppThemeColor.pureBlackColor,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
            )),
        buttonLoading
            // // Loading Overlay:
           // There's an overlay for showing a loading indicator when buttonLoading is true. This is useful to indicate that some asynchronous task is in progress, such as verifying the phone number or performing signup. When buttonLoading is true, an overlay with a loader view is displayed on top of the rest of the content.
            ? AppConstents().loaderView(
                message: 'Please wait!',
                image: 'images/loading.png',
                width: _screenWidth,
                height: 110,
              )
            : const SizedBox(),
      ],
    );
  }

  Future<void> _signUpCalled() async {
    // _signUpCalled() Method:
    // This method is called when the user taps the "Signup" button. It performs several tasks related to signup:
    //
    // It first validates the form using the _formKey.
    // If the form is valid, it sets buttonLoading to true to show the loading overlay.
    // It constructs the complete phone number by combining the code and number provided by the user.
    // It uses Firebase Authentication (FirebaseAuth) to verify the phone number provided by the user. It sends a verification code to the user's phone number using the verifyPhoneNumber method.
    // The method also handles scenarios like verification success, verification failure, and code sent to the user's phone number.
    if (_formKey.currentState!.validate()) {
      setState(() {
        buttonLoading = true;
      });
      String phoneNumber = '${codeController.text}${numberController.text}';
      print("phoneNumber>>${phoneNumber}");
      FirebaseAuth auth = FirebaseAuth.instance;

      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!
          print('verification is done');
          // Sign the user in (or link) with the auto-generated credential
          // await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Failed>>>>${e}");
          if (e.code == 'invalid-phone-number') {
            setState(() {
              buttonLoading = false;
            });
            ShowToast().showNormalToast(msg: 'invalid OTP!');
            print('The provided phone number is not valid.');
          }

          // Handle other errors
        },
        codeSent: (String verificationId, int? resendToken) async {
          print('code sent is done');
          setState(() {
            buttonLoading = false;
          });
          RouterClass().otpScreeRoute(
            context: context,
            phoneNumber: phoneNumber,
            createAccount: true,
            userName: userNameController.text,
            password: passwordController.text,
            verificationId: verificationId,
          );
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }
}
