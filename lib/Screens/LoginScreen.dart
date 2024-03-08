import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partner/Firebase/FirebaseDatabaseHelper.dart';
import 'package:partner/Utils/AppConstents.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/Utils/Router.dart';
import 'package:partner/Utils/Toast.dart';
import 'package:partner/Utils/dimensions.dart';

//The class LoginScreen extends StatefulWidget, which means it represents a widget that has mutable state. This allows the widget to change its appearance and behavior over time.
class LoginScreen extends StatefulWidget {
  //The constructor is defined to create an instance of the LoginScreen widget. It uses a named parameter key which is passed to the superclass constructor using super.key. Note that the const keyword here indicates that this constructor can be used to create a constant instance of the widget if all its fields are constant.
  const LoginScreen({super.key});

  @override //The @override annotation indicates that this method is intended to override a method from a superclass, usually from a widget's base class.
  //The createState() method returns an instance of _LoginScreenState. This method is called when the widget is inserted into the widget tree and creates the associated mutable state for this widget.
  State<LoginScreen> createState() => _LoginScreenState();
}

//_LoginScreenState is a private class the state class associated with the LoginScreen widget. in short  it is a state that belongs to the LoginScreen widget.
class _LoginScreenState extends State<LoginScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width; //This line defines width of the screen.that uses the current context and then accesses the size.width property to get the screen width.
  late final _screenHeight = MediaQuery.of(context).size.height;   //This line defines height of the screen.that uses the current context and then accesses the size.height property to get the screen height.

  //This line declares a GlobalKey object with the type parameter FormState. A GlobalKey is a reference to a stateful widget that can be used to access the state of the widget across the widget tree.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //This line declares a TextEditingController object named 'controllerName'. It is used to control an input field and access its value or modify it programmatically.
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //This line declares a boolean variable named  and initializes it with the value false.
  bool remindMe = false;
  bool buttonLoading = false;

  @override  //The @override annotation indicates that this method is intended to override a method from a superclass, usually from a widget's base class.
  //This is the build method, which is a required method in every Flutter widget. It is responsible for building and returning the widget tree for the given stateful widget.
  Widget build(BuildContext context) {
    //The Scaffold widget provides a basic structure for a typical mobile app screen, including an app bar, body, and other optional features like floating action buttons, drawers, etc.
    return Scaffold(
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    //Stack widget allows you to place multiple widgets on top of each other.
    return Stack(
      alignment: Alignment.center,   // alignment property set to Alignment.center, which means the child widgets within the Stack will be centered both horizontally and vertically.
      children: [
        //The Container is set to occupy the full screen width and height, as specified by the _screenWidth and _screenHeight variables.
        Container(
            width: _screenWidth,
            height: _screenHeight,
            color: AppThemeColor.backGroundColor, // set container background color
            padding: const EdgeInsets.all(20), //This padding creates space around the content of the container.
            child: SingleChildScrollView(  //SingleChildScrollView, which allows the content to be scrollable when the keyboard is shown to avoid overflowing content.
            // Form widget is used to create a form and manage form validation and submission.
              child: Form(
                key: _formKey, //give form key
                child: Column(
                  //These properties help in defining the layout of the child widgets inside the parent widget
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Image.asset('images/inAppIcon.png')), // These Image.asset widgets load and display images from the assets of the app.
                    const Center(
                      //Display Login Text with specific color and fontSize
                      child: Text(
                        'LOGIN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppThemeColor.darkBlueColor,
                          fontSize: 41,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, //Aligns the children at the left side of the Column.
                      children: [
                        //Display phoneNumber text with specific color,size and weight
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
                                  maxLength: 4, //TextFormField allowing it to display up to 4 lines of text. This means the user can input multiple lines of text within the TextFormField.
                                  controller: _codeController, //The controller allows you to interact with the text entered in the field, read its value, or set its value programmatically.
                                  //InputDecoration provides styling options for the text input field
                                  decoration: const InputDecoration(
                                    // hintText acts as a placeholder text to guide the user on what to write in the input field.
                                    hintText: '+61',
                                    counterText: '',
                                  ),
                                  keyboardType: TextInputType.phone, //TextInputType.phone, it allows the system to display a numeric keyboard by default
                                  // The validator property is a callback function that is executed to perform form validation on the input value of the TextFormField.
                                  // It takes the input value as an argument and returns an error message  if the value is not valid. If the input is valid, the function should return null.
                                  validator: (value) => value!.length > 1
                                      ? null
                                      : 'Country code!',
                                ),
                              ),
                            ),
                            // SizedBox is used to add some spacing.
                            const SizedBox(
                              width: 15,
                            ),
                            //The Expanded widget takes up the remaining horizontally space.
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: AppThemeColor.pureWhiteColor,
                                ),
                                //TextFormField, which is a widget that allows users to input text.
                                child: TextFormField(
                                  controller: _phoneNumberController, //The controller allows you to interact with the text entered in the field, read its value, or set its value programmatically.
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                      hintText: '413525565'),
                                  // The validator property is a callback function that is executed to perform form validation on the input value of the TextFormField.
                                  // It takes the input value as an argument and returns an error message  if the value is not valid. If the input is valid, the function should return null.
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
                        //Display password Text
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
                              //display icon lock with specific color and size
                              const Icon(
                                Icons.lock,
                                color: AppThemeColor.darkBlueColor,
                                size: 22,
                              ),
                              // SizedBox is used to add some spacing.
                              const SizedBox(
                                width: 15,
                              ),
                              //The Expanded widget takes up the remaining vertical space.
                              Expanded(
                                //TextFormField, which is a widget that allows users to input text.
                                child: TextFormField(
                                  controller: _passwordController,  //The controller allows you to interact with the text entered in the field, read its value, or set its value programmatically.
                                  decoration: const InputDecoration(
                                      hintText: 'Password'),
                                ),
                              ),
                              //Display icon remove_red_eye with specific color and size
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //InkWell is a Flutter widget that provides a rectangular area that responds to touch events. It's commonly used to create buttons or interactive elements.
                            InkWell(
                              //RouterClass is called with the forgetPasswordScreeRoute function, and the context from the current widget is passed as a parameter.
                              onTap: () => RouterClass()
                                  .forgetPasswordScreeRoute(context: context),
                              //Container widget is used to define a rectangular visual element. In this case, it has a transparent background color.
                              child: Container(
                                color: Colors.transparent,
                                //Text widget displays the text "Forget Password?" in the center with a specific font size and color.
                                child: const Text(
                                  'Forget Password?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppThemeColor.pureBlackColor,
                                    fontSize: Dimensions.fontSizeSmall,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                //This seems to be a custom widget (not a built-in Flutter widget) representing a radio button. It takes several properties:
                                RadioMenuButton(
                                  groupValue: remindMe, //The value representing the currently selected radio button in the group.
                                  value: true, //The value of this specific radio button. When this radio button is selected, it will set remindMe to true.
                                  //This sets the style of the radio button. In this case, it sets the iconSize to 20 when the button is in the default state.
                                  style: ButtonStyle(
                                    iconSize: MaterialStateProperty.all(20),
                                  ),
                                  //This is a callback function that is executed when the radio button's selection state changes. It updates the remindMe variable when the radio button is selected.
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        remindMe = value;
                                      });
                                    }
                                  },
                                  //Text widget with the text "Remember Me." It also has some custom styling, including a specified font size and color.
                                  child: const Text(
                                    'Remember Me',
                                    style: TextStyle(
                                      color: AppThemeColor.pureBlackColor,
                                      fontSize: Dimensions.fontSizeSmall,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          //InkWell is a Flutter widget that provides a rectangular area that responds to touch events. It's commonly used to create buttons or interactive elements.
                          child: InkWell(
                            //When the user taps on the InkWell, it triggers the _signUpCalled() function.
                            onTap: () => _signInCalled(),
                            child: Container(
                              width: 150,
                              padding: const EdgeInsets.symmetric(vertical: 5),  //The Container has 5 pixels of vertical padding inside it.
                              alignment: Alignment.center,
                              //it allows you to add decoration to the Container. it uses BoxDecoration to give the Container a background color and rounded corners.
                              decoration: BoxDecoration(
                                color: AppThemeColor.darkBlueColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              //Display Text LOGIN with specific color
                              child: const Text(
                                'LOGIN',
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
                          //InkWell is a Flutter widget that provides a rectangular area that responds to touch events. It's commonly used to create buttons or interactive elements.
                          child: InkWell(
                            //RouterClass is called with the createNewAccountScreeRoute function, and the context from the current widget is passed as a parameter.
                            onTap: () => RouterClass()
                                .createNewAccountScreeRoute(context: context),
                            //Text widget displays the text "Create a New Account?" in the center with a specific font size and color.
                            child: const Text(
                              'Create a New Account?',
                              style: TextStyle(
                                color: AppThemeColor.pureBlackColor,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox is used to add some spacing at the bottom of the Column.
                    const SizedBox(),
                  ],
                ),
              ),
            )),
        buttonLoading  //This is a boolean variable that indicates whether the button is in a loading state for some action
        //This seems to be a custom method that returns a loading view widget. It accepts parameters like message, image, width, and height to customize the loading view.
            ? AppConstents().loaderView(
                message: 'Please wait!',
                image: 'images/loading.png',
                width: _screenWidth,
                height: 110,
              )
            : const SizedBox(), //This is an empty widget  that is displayed when none of the loading states are true. It acts as a placeholder when there is no loading view to show.
      ],
    );
  }

  Future<void> _signInCalled() async {
    //This line checks if the form data is valid. The _formKey is probably a GlobalKey<FormState> associated with a Form widget that contains the input fields for phone number and password.
    // The validate() method checks if the form fields have valid values and returns true if everything is valid.
    if (_formKey.currentState!.validate()) {
      setState(() {
        buttonLoading = true; //If the form is valid, it sets the buttonLoading state variable to true.
      });

      //This line constructs the phone number by concatenating the values from _codeController and _phoneNumberController.
      String phoneNumber =
          '${_codeController.text}${_phoneNumberController.text}';

      //t seems FirebaseDatabaseHelper is a custom class that interacts with Firebase Realtime Database. It is trying to get a user's data from the database based on the provided phoneNumber.
      await FirebaseDatabaseHelper()
          .getUsersByPhoneNumber(phoneNumber: phoneNumber)
          .then((phoneAuthUser) async {
        if (phoneAuthUser != null) {
          if (phoneAuthUser.password == _passwordController.text) {
            FirebaseAuth auth = FirebaseAuth.instance;

            //This is part of the Firebase Authentication process. It sends a verification code to the provided phoneNumber using Firebase Phone Authentication.
            await auth.verifyPhoneNumber(
              phoneNumber: phoneNumber,

              //this callback is called when the verification is completed automatically (only on Android). It prints a message and could sign the user in with the auto-generated credential.
              verificationCompleted: (PhoneAuthCredential credential) async {
                // ANDROID ONLY!
                print('verification is done');
                // Sign the user in (or link) with the auto-generated credential
                // await auth.signInWithCredential(credential);
              },

              //This callback is called when the verification process encounters an error. It handles the 'invalid-phone-number' error and updates the buttonLoading state variable to false.
              verificationFailed: (FirebaseAuthException e) {
                if (e.code == 'invalid-phone-number') {
                  print('The provided phone number is not valid.');
                  setState(() {
                    buttonLoading = false;
                  });
                }

                // Handle other errors
              },

              //This callback is called when the verification code is sent successfully.

              codeSent: (String verificationId, int? resendToken) async {
                setState(() {
                  buttonLoading = false;
                });
                print('code sent is done');
                  //  navigates to the OTP screen using the RouterClass().otpScreeRoute() method, passing various parameters such as phoneNumber, password, createAccount, etc.
                RouterClass().otpScreeRoute(
                  context: context,
                  phoneNumber: phoneNumber,
                  password: _passwordController.text,
                  createAccount: false,
                  userName: '',
                  verificationId: verificationId,
                );
              },
              timeout: const Duration(seconds: 60), //This parameter sets the timeout duration for the phone number verification process
              codeAutoRetrievalTimeout: (String verificationId) {}, //This parameter is a callback function that is triggered when the auto-retrieval timeout occurs.
            );
          } else {
            ShowToast().showNormalToast(msg: 'Invalid Password'); // A toast message is displayed to inform the user that the password is incorrect,
            setState(() {
              buttonLoading = false;
            });
          }
        } else {
          ShowToast().showNormalToast(msg: 'User doesn\'t exists');
          setState(() {
            buttonLoading = false;
          });
        }
      });
    }
  }
}
