//import statements are standard practices in Flutter development to bring in the necessary libraries, custom files, and utilities needed for building a Flutter application.

import 'package:flutter/material.dart';
import 'package:partner/Utils/Router.dart';
import 'package:partner/Utils/dimensions.dart';

import '../Utils/AppConstents.dart';
import '../Utils/Colors.dart';


//The class SingleCategoryScreen extends StatefulWidget, which means it represents a widget that has mutable state. This allows the widget to change its appearance and behavior over time.
class SingleCategoryScreen extends StatefulWidget {

  final String selectedCategory; //This is a required parameter of type String. It is used to pass the selected category to the SingleCategoryScreen widget.
  const SingleCategoryScreen({super.key, required this.selectedCategory}); ////This is the constructor for the SingleCategoryScreen widget. It takes an optional named parameter key (inherited from the StatefulWidget class) and a required named parameter selectedCategory

  @override //The @override annotation indicates that this method is intended to override a method from a superclass, usually from a widget's base class.
  //The createState() method returns an instance of _SingleCategoryScreenState. This method is called when the widget is inserted into the widget tree and creates the associated mutable state for this widget.
  State<SingleCategoryScreen> createState() => _SingleCategoryScreenState();
}
//_SingleCategoryScreenState is a private class the state class associated with the SingleCategoryScreen widget. in short  it is a state that belongs to the SingleCategoryScreen widget.
class _SingleCategoryScreenState extends State<SingleCategoryScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;  //This line defines width of the screen.that uses the current context and then accesses the size.width property to get the screen width.
  late final _screenHeight = MediaQuery.of(context).size.height;    //This line defines height of the screen.that uses the current context and then accesses the size.height property to get the screen height.

  // These variables are used to keep track of the total number of questions and the currently displayed question, respectively. This suggests that the screen might be displaying a series of questions and tracking the user's progress through them.
  int totalQuestions = 10;
  int currentQuestion = 1;
  String? selectedCategory; //This variable is declared to store the selected category received from the constructor.


  @override  //The @override annotation indicates that this method is intended to override a method from a superclass, usually from a widget's base class.
  //this method is called when the stateful widget is inserted into the widget tree for the first time
  void initState() {
    selectedCategory = widget.selectedCategory; //store the selected category received from the constructor.
    super.initState();
  }

  @override  //The @override annotation indicates that this method is intended to override a method from a superclass, usually from a widget's base class.

  //This is the build method, which is a required method in any widget that extends StatefulWidget or its subclasses. and this  method is called by the Flutter framework whenever the widget needs to be rebuilt.
  Widget build(BuildContext context) {
    //Scaffold is a class in flutter which provides many widgets or we can say APIs like Drawer, Snack-Bar, Bottom-Navigation-Bar, Floating-Action-Button, App-Bar, etc. Scaffold will expand or occupy the whole device screen. It will occupy the available space
    return Scaffold(
      //The SafeArea widget is used to ensure that its child's content is not obscured by system overlays, such as the system status bar or device notches. It pads its child's content to avoid overlapping with these areas.
      body: SafeArea(
        child: _bodyView(), //The _bodyView() is likely a private method that returns another widget to be displayed as the main content of the Scaffold.
      ),
    );
  }

  Widget _bodyView() {
    //The Container is set to occupy the full screen width and height, as specified by the _screenWidth and _screenHeight variables.
    return Container(
      height: _screenHeight,
      width: _screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7), //This padding creates space around the content of the container.
      //The Container is decorated with a BoxDecoration, which sets the background color to AppThemeColor.backGroundColor. This color is likely a defined constant or a theme color used in the app.
      decoration: const BoxDecoration(
        color: AppThemeColor.backGroundColor,
      ),
      //Column widget that contains the main content of the screen, arranged vertically.
      child: Column(
        children: [
          AppConstents().topBarViewWithBack(context: context), //This method defined in the AppConstants class, returns a widget representing the top bar view with a back button or back icon. The context parameter is passed to this method, allowing it to build the appropriate widget.
          //SizedBox with a height of 15 pixels, creating a vertical space between the top bar view and the rest of the content.
          const SizedBox(
            height: 15,
          ),
          //Row widget that contains the main content of the screen, arranged Horizontally.
          Row(
            //In Row, children are aligned from top to bottom. Main Axis is vertical and the Cross Axis is horizontal. MainAxisAlignment aligns its children vertically and CrossAxisAlignment aligns horizontally in that Row.
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: _screenWidth / 2.4,
                decoration: BoxDecoration(
                  color: AppThemeColor.pureWhiteColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(
                  children: [
                    Image.asset(
                      'images/connectedIcon.png',
                      width: 22,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text(
                      'Connected',
                      style: TextStyle(
                        color: AppThemeColor.darkBlueColor,
                        fontWeight: FontWeight.w400,
                        fontSize: Dimensions.fontSizeDefault,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: _screenWidth / 2.4, //The width of the container is set to be approximately 2.4 times smaller than the screen width. This will make the container occupy a portion of the screen's width.
                decoration: BoxDecoration(
                  color: AppThemeColor.pureWhiteColor, // set container background color
                  borderRadius: BorderRadius.circular(7), //customized container with  rounded corners with a circular border radius of 7 pixels.
                ),
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0), //The content inside the container is padded symmetrically with 25 pixels on the horizontal axis and 10 pixels on the vertical axis.
                child: Row(
                  children: [
                    //This is an image widget displaying an image loaded from the asset. and image has a width of 22 pixels.
                    Image.asset(
                      'images/categoriesIcon.png',
                      width: 22,
                    ),
                    const SizedBox( //A fixed-sized box with a width of 6 pixels. It creates a gap between the image and the text.
                      width: 6,
                    ),
                    //DropdownButton widget, which is a common Flutter widget used to create dropdown menus
                    DropdownButton<String>( //The generic type String is specified in angle brackets (<>) to indicate the type of values that will be used in the dropdown.
                      padding: const EdgeInsets.all(0),
                       value: selectedCategory, //The value property represents the currently selected value in the dropdown.
                      //The items property is where you specify the list of dropdown menu items to be displayed. t takes a list of DropdownMenuItem widgets. In this code, it uses AppConstents().categoriesList to get a list of strings representing the categories.
                      items: AppConstents().categoriesList.map((String value) {
                        return DropdownMenuItem<String>( //widget represents each individual item in the dropdown list.
                          value: value,
                          child: Text(value.replaceAll('\n', ' ')), //replaceAll('\n', ' ') method is used to remove any newline characters  in the category name and replace them with spaces. This might be useful if the categoriesList contains strings with newline characters, and you want to display the items without those newline breaks.
                        );
                      }).toList(),
                      // This property is a callback function that will be called when the user selects an item from the dropdown menu
                      onChanged: (value) {
                        //The value of the selected item will be passed to this callback. In this code, it checks if the value is not null  and if it's not null, it sets the selectedCategory variable using setState.
                        if (value != null) {
                          setState(() {
                            selectedCategory = value;
                          });
                        }
                      },
                    )

                    // Text(
                    //   widget.selectedCategory,
                    //   style: const TextStyle(
                    //     color: AppThemeColor.darkBlueColor,
                    //     fontWeight: FontWeight.w400,
                    //     fontSize: Dimensions.fontSizeDefault,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppThemeColor.darkBlueColor,
              borderRadius: BorderRadius.circular(7),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10), //The container has vertical margin of 10 pixels, providing spacing between this container and other elements.
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7,
            ),
            //Row widget, allowing its children to be displayed horizontally in a row.
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    //Icon widget displays the "watch later" icon in white color The icon has a size of 18 pixels.
                    Icon(
                      Icons.watch_later_outlined,
                      color: AppThemeColor.pureWhiteColor,
                      size: 18,
                    ),
                    // The Text widget displays the timer value as ' 00:00'. The text is styled with white color and a font size of Dimensions.fontSizeDefault, which is likely a constant representing a specific font size.
                    Text(
                      ' 00:00',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppThemeColor.pureWhiteColor,
                        fontSize: Dimensions.fontSizeDefault,
                      ),
                    ),
                  ],
                ),
                Text(
                  '< $currentQuestion/$totalQuestions', //displaying the current question number out of the total number of questions.  For example, "< 3/10"
                  textAlign: TextAlign.center, // set text is centered alignment
                  style: const TextStyle(
                    color: AppThemeColor.pureWhiteColor,
                    fontSize: Dimensions.fontSizeDefault,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppThemeColor.pureWhiteColor,
              borderRadius: BorderRadius.circular(7),
            ),
            width: _screenWidth,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7,
            ),
            child: const Text(
              'What is the favourite color of user 1?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppThemeColor.darkBlueColor,
                fontSize: Dimensions.fontSizeDefault,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          //The Expanded widget takes up the remaining vertical space.
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppThemeColor.pureWhiteColor,
              ),
              //TextFormField, which is a widget that allows users to input text.
              child: TextFormField(
                maxLines: 7, //TextFormField allowing it to display up to 7 lines of text. This means the user can input multiple lines of text within the TextFormField.
                decoration:
                    //InputDecoration provides styling options for the text input field
                    InputDecoration(hintText: 'Write down your Answer Here.'), // hintText acts as a placeholder text to guide the user on what to write in the input field.
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //which means the buttons will be placed as far apart from each other as possible, horizontally.
            children: [
              //When the button is tapped, the function will be called,
              InkWell(
                onTap: () {
                  //Whenever you change the internal state of a State object, make the change in a function that you pass to setState:
                  setState(() {
                    if (currentQuestion != 1) {
                      currentQuestion--;
                    }
                  });
                },
                child: Container(
                  width: _screenWidth / 2.5, //The width of the container is set to be approximately 2.5 times smaller than the screen width. This will make the container occupy a portion of the screen's width.
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppThemeColor.darkBlueColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      color: AppThemeColor.pureWhiteColor,
                    ),
                  ),
                ),
              ),
              //When the button is tapped, the function will be called,
              InkWell(
                onTap: () {
                  //Whenever you change the internal state of a State object, make the change in a function that you pass to setState:
                  setState(() {
                    if (currentQuestion != totalQuestions) {
                      currentQuestion++;
                    }
                  });
                },
                child: Container(
                  width: _screenWidth / 2.5, //The width of the container is set to be approximately 2.5 times smaller than the screen width. This will make the container occupy a portion of the screen's width.
                  padding: const EdgeInsets.symmetric(vertical: 5),//This padding creates space vertically the content of the container.
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppThemeColor.pureWhiteColor,
                    borderRadius: BorderRadius.circular(4),
                    //border: The Container also has a border defined with a width of 0.4 pixels and a color of AppThemeColor.grayColor. This creates a thin gray border around the button, enhancing its visual appearance.
                    border: Border.all(
                      width: 0.4,
                      color: AppThemeColor.grayColor,
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: AppThemeColor.pureBlackColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //which means the buttons will be placed as far apart from each other as possible, horizontally.
            children: [
              //When the button is tapped, the function will be called,
              InkWell(
                onTap: () =>
                    RouterClass().afterQuestionsScreenRoute(context: context), //The RouterClass is contains methods for navigating between screens.
                child: Container(
                  width: _screenWidth / 2.5, //The width of the container is set to be approximately 2.5 times smaller than the screen width. This will make the container occupy a portion of the screen's width.
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppThemeColor.darkBlueColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: AppThemeColor.pureWhiteColor,
                    ),
                  ),
                ),
              ),
              //When the button is tapped, the function will be called,
              InkWell(
                //method is used to pop the current route (screen) off the navigation stack and return to the previous screen. It takes the BuildContext as an argument, which is provided by the context variable in Flutter.
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: _screenWidth / 2.5,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppThemeColor.pureWhiteColor,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      width: 0.4,
                      color: AppThemeColor.grayColor,
                    ),
                  ),
                  child: const Text(
                    'Quit',
                    style: TextStyle(
                      color: AppThemeColor.pureBlackColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
