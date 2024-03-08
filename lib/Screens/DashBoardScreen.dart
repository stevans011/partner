import 'package:flutter/material.dart';
// Flutter Material package for widgets and UI components.
import 'package:partner/Screens/AccountScreen.dart';
// Custom utility file for Account Screen usage.
import 'package:partner/Screens/HistoryScreen.dart';
// Custom utility file for History Screen usage.
import 'package:partner/Screens/HomeScreen.dart';
// Custom utility file for Account Screen usage.
import 'package:partner/Utils/Colors.dart';
// Custom utility file for application colors.
import '../Firebase/FirebaseDatabaseHelper.dart';
// Custom utility file for Firebase Services.
import '../Objects/UserObject.dart';
// Custom utility file for User Objects.
import 'ConnectScreen.dart';
// Custom utility file for Connect Screen usage.

class DashBoardScreen extends StatefulWidget {
  // Defining a stateful widget DashBoardScreen that extends StatefulWidget. The widget takes no required parameters.
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
//   Defining the _DashBoardScreenState class, which extends the State class for managing the state of the widget.
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  // Inside the state class, two variables _screenWidth and _screenHeight are declared, and they are assigned the width and height of the device screen using MediaQuery.

  String selectedTab = 'Home';
  // String selectedTab = 'Home';: This line declares a variable selectedTab of type String and initializes it with the value 'Home'. This variable is likely used to keep track of the currently selected tab in the dashboard.
  UserObject? userData;
  // UserObject? userData;: This line declares a variable userData of type UserObject?. The UserObject type is nullable (UserObject?) because it's not assigned any initial value, so it defaults to null. This variable is used to store the user data retrieved from the FirebaseDatabaseHelper.

  Future<void> getUserData() async {
    // Future<void> getUserData() async { ... }: This is a method named getUserData, which returns a Future<void>. It is marked with the async keyword, indicating that it can use await inside its body to wait for asynchronous operations.
    await FirebaseDatabaseHelper().getUsers().then((user) {
      // await FirebaseDatabaseHelper().getUsers().then((user) { ... });: This line calls the getUsers method from the FirebaseDatabaseHelper class. The await keyword is used to wait for the result of this asynchronous call. Once the result is available, the then callback function is executed.
      if (user != null) {
        // if (user != null) { ... }: Inside the then callback, it checks if the retrieved user is not null.
        setState(() {
          // setState(() { userData = user; });: If the user is not null, it uses the setState method to update the state of the widget. It assigns the retrieved user to the userData variable, triggering a rebuild of the widget and updating the UI with the new user data.
          userData = user;
        });
      }
    });
  }

  Future<void> getFullUserData() async {
    // Future<void> getFullUserData() async { ... }: This method is named getFullUserData and returns a Future<void>. It is marked with the async keyword, indicating that it can use await inside its body to wait for asynchronous operations.
    await FirebaseDatabaseHelper().getFullUsers().then((user) {
      // await FirebaseDatabaseHelper().getFullUsers().then((user) { ... }): This line calls the getFullUsers method from the FirebaseDatabaseHelper class. The await keyword is used to wait for the result of this asynchronous call. Once the result is available, the then callback function is executed.
      if (user != null) {
        // if (user != null) { ... } else { ... }: Inside the then callback, it checks if the retrieved user is not null.
        setState(() {
          // setState(() { userData = UserObject(...); });: If the user is not null, it uses the setState method to update the state of the widget. It creates a new UserObject using the data obtained from the user object. The UserObject is likely a custom data model representing a user with properties like uid, userName, password, and phoneNumber. The new UserObject is then assigned to the userData variable.
          userData = UserObject(
              uid: user.uid!,
              userName: user.userName!,
              password: '',
              phoneNumber: user.phoneNumber!);
        });
      } else {
        // else { getUserData(); }: If the user is null, it calls the getUserData() method. This suggests that if the full user data is not available, it falls back to getting partial user data using the getUserData() method (defined in your previous code snippet).
        getUserData();
      }
    });
  }

  @override
  void initState() {
    // void initState(): This is an overridden method from the State class and is called when the stateful widget is inserted into the widget tree. It is a good place to perform one-time setup for the widget. In this case, you are calling the getFullUserData() method inside initState(), which means it will be executed when the DashBoardScreen widget is first created.
    getFullUserData();
    // getFullUserData();: As mentioned in the previous responses, this method is responsible for fetching full user data from Firebase and updating the userData variable using the setState method.
    super.initState();
    //   super.initState();: This line calls the initState method of the superclass (State class). It's essential to call this to ensure that the superclass's initialization is performed correctly.
  }

  @override
  Widget build(BuildContext context) {
    // Widget build(BuildContext context): This is an overridden method from the State class and is called whenever the widget needs to be rebuilt. It returns the UI for the widget.
    return Scaffold(
      // return Scaffold(body: _bodyView());: In the build method, you are returning a Scaffold widget with the _bodyView() method as its body. The Scaffold widget is a basic structure for implementing Material Design layouts in Flutter apps. The _bodyView() method, which is not shown in the provided code, is expected to return a widget that will be displayed as the main content of the Scaffold.
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return Container(
      // return Container(...): The _bodyView() method returns a Container widget as the root widget.
      height: _screenHeight,
      // height: _screenHeight, width: _screenWidth,: The height and width properties of the Container are set to _screenHeight and _screenWidth, respectively. These variables likely represent the height and width of the screen.
      width: _screenWidth,
      decoration: const BoxDecoration(
        // decoration: const BoxDecoration(color: AppThemeColor.backGroundColor),: The Container has a BoxDecoration that sets its background color to AppThemeColor.backGroundColor. It seems like AppThemeColor is a custom class or file that provides color definitions for the app.
        color: AppThemeColor.backGroundColor,
      ),
      child: Column(
        // child: Column(...): The Container has a Column widget as its child, which allows multiple widgets to be stacked vertically.
        children: [
          Expanded(
            // Expanded(...): The Expanded widget is used as a child of the Column, and it takes up all the available vertical space within the Column. This is important to ensure that the content of the selected tab takes up the majority of the screen space.
            child: selectedTab == 'Home'
                ? const HomeScreen()
                : selectedTab == 'Connect'
                    ? const ConnectScreen()
                    : selectedTab == 'History'
                        ? const HistoryScreen()
                        : selectedTab == 'Account'
                            ? const AccountScreen()
                            : const SizedBox(),
            //   Conditional Widget Rendering: Inside the Expanded widget, there are conditional expressions that determine which screen to display based on the value of the selectedTab variable. The selectedTab variable is likely updated elsewhere in the code when the user switches between tabs. The possible screens that can be displayed are HomeScreen, ConnectScreen, HistoryScreen, and AccountScreen. Only one of these screens will be displayed at a time, based on the value of selectedTab.
          ),
          _bottomBarView(),
          //   _bottomBarView(): After the Expanded widget, there's a call to the _bottomBarView() method, which is expected to return the widget representing the bottom navigation bar of the DashBoardScreen. The _bottomBarView() implementation is not provided in the code snippet.
        ],
      ),
    );
  }

  Widget _bottomBarView() {
    return Container(
      // return Container(...): The _bottomBarView() method returns a Container widget as the root widget.
      height: 65,
      // height: 65,: The height property of the Container is set to 65, which defines the height of the bottom navigation bar.
      decoration: BoxDecoration(
        // decoration: BoxDecoration(...): The Container has a BoxDecoration that sets its background color to AppThemeColor.pureWhiteColor and adds a rounded border with a BorderRadius.circular(50) to give the bottom navigation bar a rounded look.
        color: AppThemeColor.pureWhiteColor,
        borderRadius: BorderRadius.circular(50),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      // margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),: The Container has a margin of 10 pixels vertically and 5 pixels horizontally, which creates some spacing around the bottom navigation bar.
      padding: const EdgeInsets.symmetric(horizontal: 15),
      // padding: const EdgeInsets.symmetric(horizontal: 15),: The Container has a padding of 15 pixels horizontally, which adds some space between the icons and the edges of the bottom navigation bar.
      child: Row(
        // child: Row(...): Inside the Container, there's a Row widget as the child, which aligns its children in a horizontal row.
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // _singleBottomButton(...): The Row contains multiple _singleBottomButton widgets separated by VerticalDivider widgets. The _singleBottomButton is a custom widget (not shown in the code snippet) that displays an icon and a title for each tab in the bottom navigation bar.
          _singleBottomButton(iconData: Icons.home_filled, title: 'Home'),
          // const VerticalDivider(...): The VerticalDivider widget is used to create vertical lines between the bottom navigation bar items. It provides a visual separation between the different tabs.
          const VerticalDivider(
            width: 1,
            color: AppThemeColor.pureBlackColor,
            indent: 10,
            endIndent: 10,
          ),
          _singleBottomButton(iconData: Icons.favorite, title: 'Connect'),
          const VerticalDivider(
            width: 1,
            color: AppThemeColor.pureBlackColor,
            indent: 10,
            endIndent: 10,
          ),
          _singleBottomButton(iconData: Icons.history, title: 'History'),
          const VerticalDivider(
            width: 1,
            color: AppThemeColor.pureBlackColor,
            indent: 10,
            endIndent: 10,
          ),
          _singleBottomButton(iconData: Icons.person, title: 'Account'),
        ],
      ),
    );
  }

  Widget _singleBottomButton(
      // Widget _singleBottomButton(...){...}: This method returns a custom widget representing a single button in the bottom navigation bar.
      {required IconData iconData,
      required String title}) {
    // {required IconData iconData, required String title}: The method takes two required parameters: iconData of type IconData (the icon data for the button) and title of type String (the title for the button).
    return Expanded(
      // return Expanded(...): The _singleBottomButton widget returns an Expanded widget as the root widget. This allows the button to take up equal horizontal space within the bottom navigation bar.
      child: InkWell(
        // child: InkWell(...): Inside the Expanded, there's an InkWell widget, which is used to make the button interactive and respond to taps.
        onTap: () {
          // onTap: (){...}: The InkWell widget has an onTap callback that triggers when the button is tapped. Inside the callback, it uses setState to update the selectedTab variable to the title of the button that was tapped. This will change the selected tab and trigger a rebuild of the UI to show the content of the selected tab.
          setState(() {
            selectedTab = title;
          });
        },
        child: Column(
          // child: Column(...): The InkWell has a Column as its child, allowing for the icon and title to be displayed vertically.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              // Icon(...): Inside the Column, there's an Icon widget representing the button's icon. The size of the icon is set to 22, and its color is determined based on whether the button's title matches the current selectedTab. If it matches, it uses AppThemeColor.darkBlueColor, otherwise, it uses AppThemeColor.dullFontColor.
              iconData,
              size: 22,
              color: selectedTab == title
                  ? AppThemeColor.darkBlueColor
                  : AppThemeColor.dullFontColor,
            ),
            Text(
              // Text(...): Below the icon, there's a Text widget representing the button's title. The style of the text is determined based on whether the button's title matches the current selectedTab. If it matches, it uses AppThemeColor.darkBlueColor, otherwise, it uses AppThemeColor.dullFontColor.
              title,
              style: TextStyle(
                  color: selectedTab == title
                      ? AppThemeColor.darkBlueColor
                      : AppThemeColor.dullFontColor),
            )
          ],
        ),
      ),
    );
  }
}
