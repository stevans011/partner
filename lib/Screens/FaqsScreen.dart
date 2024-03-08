import 'package:flutter/material.dart';
// Flutter Material package for widgets and UI components.
import 'package:partner/Utils/AppConstents.dart';
// Custom utility file for application constants.
import '../Utils/Colors.dart';
// Custom utility file for application colors.

class FaqsScreen extends StatefulWidget {
  // Defining a stateful widget FaqsScreen that extends StatefulWidget. The widget takes no required parameters.
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
//   Defining the _FaqsScreenState class, which extends the State class for managing the state of the widget.
}

class _FaqsScreenState extends State<FaqsScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;
  // Inside the state class, two variables _screenWidth and _screenHeight are declared, and they are assigned the width and height of the device screen using MediaQuery.
  @override
  Widget build(BuildContext context) {
    // Widget build(BuildContext context): This is an overridden method from the State class and is called whenever the widget needs to be rebuilt. It returns the UI for the widget.
    return Scaffold(
      // return Scaffold(body: _bodyView());: In the build method, you are returning a Scaffold widget with the _bodyView() method as its body. The Scaffold widget is a basic structure for implementing Material Design layouts in Flutter apps. The _bodyView() method, which is not shown in the provided code, is expected to return a widget that will be displayed as the main content of the Scaffold.
      body: SafeArea(
        child: _bodyView(),
      ),
    );
  }

  Widget _bodyView() {
    // return Container(...): The _bodyView() method returns a Container widget as the root widget.
    return Container(
      height: _screenHeight,
      // height: _screenHeight, width: _screenWidth,: The height and width properties of the Container are set to _screenHeight and _screenWidth, respectively. These variables likely represent the height and width of the screen.
      width: _screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: const BoxDecoration(
        // decoration: const BoxDecoration(color: AppThemeColor.backGroundColor),: The Container has a BoxDecoration that sets its background color to AppThemeColor.backGroundColor. It seems like AppThemeColor is a custom class or file that provides color definitions for the app.
        color: AppThemeColor.backGroundColor,
      ),
      child: Column(
        // Inside the Container, there is a Column widget as its child, representing a vertical arrangement of widgets.
        children: [
          AppConstents().topBarViewWithBack(context: context),
          // AppConstents().topBarViewWithBack(context: context): This seems to be a custom widget representing the top bar view with a back button. It receives the context as an argument.
          const SizedBox(
            height: 40,
            //   SizedBox(height: 40): This is a SizedBox widget with a height of 40 pixels, providing some spacing between the top bar view and the ListView.builder.
          ),
          Expanded(
            // Expanded: This widget takes the remaining vertical space available in the Column.
            child: ListView.builder(
              // ListView.builder: This is a ListView widget that dynamically generates a scrollable list of questions. It has an itemCount of 5, which means it will create 5 list items. The itemBuilder function is used to build each list item. It receives the contextOfList and the index of the item being built. For each item, the method _singleQuestion() is called with the question string as an argument.
              itemCount: 5,
              itemBuilder: (contextOfList, index) {
                return _singleQuestion(question: 'Question No ${index + 1}');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _singleQuestion({required String question}) {
    // The method takes a required parameter question, which is a string representing the question to be displayed.
    return Container(
      // The method returns a Container widget as the root widget of the question item.
      decoration: BoxDecoration(
        // decoration: It sets a background color for the container to AppThemeColor.pureWhiteColor. It also gives the container rounded corners with a border radius of 7 pixels.
        color: AppThemeColor.pureWhiteColor,
        borderRadius: BorderRadius.circular(7),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      // margin: It provides 10 pixels of vertical margin around the container, creating spacing between multiple question items.
      padding: const EdgeInsets.symmetric(
        // padding: The container has 10 pixels of horizontal padding and 7 pixels of vertical padding, creating space between the container's content and its edges.
        horizontal: 10,
        vertical: 7,
      ),
      child: Row(
        // Inside the Container, there is a Row widget as its child, representing a horizontal arrangement of widgets.
        children: [
          Expanded(
            // Expanded: This widget takes up the available horizontal space in the row and contains a Text widget. The Text widget displays the question string passed as an argument. The text color is set to AppThemeColor.darkBlueColor.
            child: Text(
              question,
              style: const TextStyle(
                color: AppThemeColor.darkBlueColor,
              ),
            ),
          ),
          const Icon(
            // Icon: This widget represents an icon. It displays the Icons.keyboard_arrow_down icon from the Flutter's built-in icon library. The icon color is set to AppThemeColor.darkBlueColor.
            Icons.keyboard_arrow_down,
            color: AppThemeColor.darkBlueColor,
          ),
        ],
      ),
    );
  }
}
