import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:partner/Firebase/FirebaseDatabaseHelper.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/Utils/Toast.dart';

import '../Objects/UserObject.dart';
import '../Utils/AppConstents.dart';
import '../Utils/Router.dart';

//StatefulWidget is used when the state of a widget may change over time, and the widget can be redrawn with new data.
//The class OtpScreen extends StatefulWidget, which means it represents a widget that has mutable state. This allows the widget to change its appearance and behavior over time.
class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String password;
  final String verificationId;
  final String userName;
  final bool createAccount;

  //The constructor OtpScreen takes all these required properties as named parameters. The required keyword ensures that these parameters must be provided when creating an instance of the OtpScreen class.
  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.password,
    required this.userName,
    required this.createAccount,
    required this.verificationId,
  });

  @override //The @override annotation indicates that this method is intended to override a method from a superclass, usually from a widget's base class.
  //The createState() method returns an instance of _SingleHistoryScreenState. This method is called when the widget is inserted into the widget tree and creates the associated mutable state for this widget.
  State<OtpScreen> createState() => _OtpScreenState();
}

//_OtpScreenState is a private class the state class associated with the OtpScreen widget. in short  it is a state that belongs to the OtpScreen widget.
class _OtpScreenState extends State<OtpScreen> {
  //The late keyword indicates that the variables will be initialized later (presumably inside the build() method)
  late final _screenWidth = MediaQuery.of(context)
      .size
      .width; //This line defines width of the screen.that uses the current context and then accesses the size.width property to get the screen width.
  late final _screenHeight = MediaQuery.of(context)
      .size
      .height; //This line defines height of the screen.that uses the current context and then accesses the size.height property to get the screen height.

  // boolean variables are declared to manage the state of the widget
  bool otpComplete = false;
  bool buttonLoading =
      false; //A boolean flag to indicate whether a general button is in a loading state
  bool createAccountButtonLoading =
      false; //A boolean flag to indicate whether the "Create Account" button is in a loading state.
  bool loginButtonLoading = false; //
  //that will store the entered OTP value.
  String? pinValue;

  //A CollectionReference  is created to interact with the Firestore collection named 'users'. It is using the FirebaseFirestore.instance.collection('users') to access the collection.
  final CollectionReference<Map<String, dynamic>> usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  @override //The @override annotation indicates that this method is intended to override a method from a superclass, usually from a widget's base class.
  //The build() is used to define the UI for the widget based on its current state.
  Widget build(BuildContext context) {
    //Scaffold is a class in flutter which provides many widgets or we can say APIs like Drawer, Snack-Bar, Bottom-Navigation-Bar, Floating-Action-Button, App-Bar, etc. Scaffold will expand or occupy the whole device screen. It will occupy the available space
    return Scaffold(
      //The _bodyView() is likely a private method that returns another widget to be displayed as the main content of the Scaffold.
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    //Stack widget allows you to place multiple widgets on top of each other.
    return Stack(
      alignment: Alignment.center, //set loading indicators alignment
      children: [
        //The Container is set to occupy the full screen width and height, as specified by the _screenWidth and _screenHeight variables.
        Container(
            width: _screenWidth,
            height: _screenHeight,
            color: AppThemeColor.backGroundColor,
            padding: const EdgeInsets.all(
                20), //This padding creates space around the content of the container.
            //Column widget that contains the main content of the screen, arranged vertically.
            child: Column(
              //These properties help in defining the layout of the child widgets inside the parent widget
              mainAxisAlignment: MainAxisAlignment
                  .spaceAround, //Distributes the children evenly along the main axis, with equal spaces between them and half of the space at the start and end of the Column.
              crossAxisAlignment: CrossAxisAlignment
                  .start, //Aligns the children at the left side of the Column.
              children: [
                Image.asset(
                    'images/inAppIcon.png'), // These Image.asset widgets load and display images from the assets of the app.
                const Center(
                  //use for widgets are placed side by side within the Row.
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Display textMessage with center alignment and specific color & fontSize
                      Text(
                        'Enter the ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppThemeColor.pureBlackColor,
                          fontSize: 30,
                        ),
                      ),
                      //Display textMessage with center alignment and specific color & fontSize
                      Text(
                        'OTP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppThemeColor.darkBlueColor,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                //Column widget that contains the main content of the screen, arranged vertically.
                Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, //Aligns the children at the left side of the Column.
                  children: [
                    // SizedBox is used to add some spacing vertically.
                    const SizedBox(
                      height: 15,
                    ),
                    //This widget is a custom implementation used for capturing the OTP input.
                    OTPTextField(
                      length:
                          6, //It specifies the length of OTP as 6 characters,
                      width: _screenWidth,
                      fieldWidth: _screenWidth /
                          8.3, //This determines the individual width of each character field in the OTP input
                      style: const TextStyle(fontSize: 17),
                      textFieldAlignment: MainAxisAlignment
                          .spaceAround, //spaceAround suggests that the OTP input fields may be distributed with space around them.
                      fieldStyle: FieldStyle
                          .box, //It sets the style of the OTP input field. FieldStyle.box indicates that the fields will have a box-style appearance.
                      //This is a callback function that is triggered when the user has completed entering the OTP
                      onCompleted: (pin) {
                        print("Completed: " + pin);
                        //setState() to update the state of the widget and trigger a rebuild of the UI with the new values.
                        setState(() {
                          otpComplete = true;
                          pinValue =
                              pin; //assigns the entered OTP to the pinValue variable.
                        });
                      },
                    ),
                    // SizedBox is used to add some spacing.
                    const SizedBox(
                      height: 35,
                    ),
                    //This section displays the "Verify OTP" button in the center of the screen. The button is wrapped in an InkWell to provide a tap effect.
                    Center(
                      child: InkWell(
                        onTap: () =>
                            _signUpCalled(), //When the user taps on the InkWell, it triggers the _signUpCalled() function.
                        //This is a basic building block in Flutter, a rectangular box that can have styling and can contain other widgets.
                        child: Container(
                          width: 150, // set fixed width of container
                          padding: const EdgeInsets.symmetric(
                              vertical:
                                  5), //The Container has 5 pixels of vertical padding inside it.
                          alignment: Alignment
                              .center, //The content inside the Container is aligned to the center.
                          //it allows you to add decoration to the Container. it uses BoxDecoration to give the Container a background color and rounded corners.
                          decoration: BoxDecoration(
                            color: AppThemeColor.darkBlueColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          //Display Text verify OTP with specific color
                          child: const Text(
                            'Verify OTP',
                            style: TextStyle(
                              color: AppThemeColor.pureWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox is used to add some spacing at the bottom of the Column.
                const SizedBox(),
              ],
            )),
        buttonLoading //This is a boolean variable that indicates whether the button is in a loading state for some action
            //This seems to be a custom method that returns a loading view widget. It accepts parameters like message, image, width, and height to customize the loading view.
            ? AppConstents().loaderView(
                message: 'Verifying Otp!',
                image: 'images/loading.png',
                width: _screenWidth,
                height: 110,
              )
            : createAccountButtonLoading // This is another boolean variable that indicates whether the button for creating an account is in a loading state.
                ? AppConstents().loaderView(
                    message: 'Creating Account!',
                    image: 'images/loading.png',
                    width: _screenWidth,
                    height: 110,
                  )
                : loginButtonLoading //This is yet another boolean variable that indicates whether the login button is in a loading state.
                    ? AppConstents().loaderView(
                        message: 'Loging in!',
                        image: 'images/loading.png',
                        width: _screenWidth,
                        height: 110,
                      )
                    : const SizedBox() //This is an empty widget  that is displayed when none of the loading states are true. It acts as a placeholder when there is no loading view to show.
      ],
    );
  }

  //Called when user create new account.
  Future<void> _signUpCalled() async {
    // if (pinValue != null) {
    // Create a PhoneAuthCredential with the code
//This is a class from the firebase_auth package that represents the credentials required for phone number authentication.
// It is being used to create a credential using the verificationId and the smsCode (the OTP entered by the user).
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: pinValue!);

//This sets the buttonLoading variable to true, which likely triggers the display of a loading view to indicate that the verification process is in progress.
    setState(() {
      buttonLoading = true;
    });

    // Sign the user in (or link) with the credential
    //signInWithCredential() method. It attempts to sign in the user using the provided credential.
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      //If the sign-in process is successful, this callback is executed with the value representing the result of the authentication.
      // If the user has been successfully signed in, it checks whether the createAccount flag is true or false. This flag might indicate whether it's a new user signing up or an existing user logging in.
      if (value.user != null) {
        if (widget.createAccount) {
          //This seems to be a custom class representing user data
          UserObject userData = UserObject(
            uid: value.user!.uid,
            userName: widget.userName,
            password: widget.password,
            phoneNumber: widget.phoneNumber,
          );
          //This sets the buttonLoading variable  and createAccountButtonLoading  to true, which likely triggers the display of a loading view to indicate that the verification process is in progress.

          setState(() {
            buttonLoading = false;
            createAccountButtonLoading = true;
          });

          addNewUserToFirebase(
              user:
                  userData); //If createAccount is true, this function is called to add a new user to Firebase with the user data from UserObject.
        } else {
          loginUserToFirebase(); //If createAccount is false, this function is called to log in the existing user to Firebase.

          setState(() {
            buttonLoading = false;
            loginButtonLoading = true;
          });
        }
      } else {
        setState(() {
          buttonLoading = false;
        });
        //If there was an error during authentication or the user is not signed in , it displays a toast message with the error message.
        ShowToast().showNormalToast(msg: 'Something is wrong!');
      }
    }).onError((error, stackTrace) {
      //if there's an error during the authentication process, this callback is executed. It prints the error and sets buttonLoading to false to stop the loading view.
      print(error);
      setState(() {
        buttonLoading = false;
      });
    });
    // }
  }

//Called when user create new account.
  //this is a function that takes a UserObject named user as a required parameter. It is assumed that UserObject is a custom class representing user data.
  Future<void> addNewUserToFirebase({required UserObject user}) async {
    try {
      DatabaseReference dbf = FirebaseDatabase.instance
          .ref(); //This line creates a reference to the root node of the Firebase Realtime Database using the FirebaseDatabase instance.
      //this line saves the user data to the Firebase Realtime Database under the "Users" node with the user.uid as the key. user.toJson() is likely a method that converts the UserObject data to a JSON format.
      await dbf
          .child('Users')
          .child(user.uid)
          .set(
            user.toJson(),
          )
          //If the data is successfully written to the database, this callback is executed.
          .then((value) {
        // Inside the callback, the createAccountButtonLoading variable is set to false to stop the loading view,
        setState(() {
          createAccountButtonLoading = false;
          RouterClass().dashBoardScreeRoute(
              context:
                  context); //the function dashBoardScreeRoute from the RouterClass is called to navigate to the dashboard screen.
        });

        // Navigator.pop(context);
      });
      // await usersCollectionReference.add(data);
      print('Data added to Firestore successfully');
    }
    //If there's an error during the data addition process, this catch block of code is executed.
    catch (error) {
      setState(() {
        createAccountButtonLoading =
            false; //In case of an error, the createAccountButtonLoading variable is set to false to stop the loading view.
      });
      //A toast message is shown to the user indicating that something went wrong during the data addition process.
      ShowToast().showNormalToast(msg: 'Something Wrong!');
      print('Error adding data to Firestore: $error');
    }
  }

  //Called when user only login.
  //This is an asynchronous function responsible for the login process.
  Future<void> loginUserToFirebase() async {
    try {
      //At the beginning of the login process, it sets the loginButtonLoading variable to true to display the loading view while the login process is ongoing.
      setState(() {
        loginButtonLoading = true;
      });

      //This line awaits the result of a call to getUsers() method from the FirebaseDatabaseHelper class. The method is used to retrieve the current user's data from the Firebase Realtime Database.
      await FirebaseDatabaseHelper().getUsers().then((currentUser) {
        //If the user data is successfully retrieved , the login process proceeds.
        if (currentUser != null) {
          //It checks whether the password entered by the user matches the password stored in the currentUser data retrieved from the database.
          if (currentUser.password == widget.password) {
            setState(() {
              loginButtonLoading =
                  false; //If the passwords match, the loginButtonLoading variable is set to false to stop the loading view,
              RouterClass().dashBoardScreeRoute(
                  context:
                      context); // // the function dashBoardScreeRoute from the RouterClass is called to navigate to the dashboard screen.
            });
          } else {
            setState(() {
              loginButtonLoading =
                  false; //If the passwords don't match, the loginButtonLoading variable is set to false to stop the loading view.
            });
            ShowToast().showNormalToast(
                msg:
                    'Password is incorrect'); // A toast message is displayed to inform the user that the password is incorrect,
            RouterClass().loginScreeRoute(
                context:
                    context); // // function loginScreeRoute from the RouterClass is called to navigate back to the login screen.
          }
        }
      });
      print('Data added to Firestore successfully');
    }
    //If there's an error during the login process, this catch block of code is executed.
    catch (error) {
      setState(() {
        loginButtonLoading =
            false; // In case of an error, the loginButtonLoading variable is set to false to stop the loading view.
      });
      print('Error adding data to Firestore: $error');
    }
  }
}
