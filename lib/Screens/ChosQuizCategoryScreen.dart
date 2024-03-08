import 'package:flutter/material.dart';
// Flutter Material package for widgets and UI components.
import 'package:partner/Utils/dimensions.dart';
// package:partner/Utils/dimensions.dart: Custom utility file for dimensions (probably for consistent spacing, etc.).
import '../Utils/AppConstents.dart';
// Custom utility file for application constants.
import '../Utils/Colors.dart';
// Custom utility file for application colors.
import '../Utils/Router.dart';
// Custom utility file for handling navigation routes.

class ChosQuizCategoryScreen extends StatefulWidget {
  // Defining a stateful widget ChosQuizCategoryScreen that extends StatefulWidget. The widget takes no required parameters.
  const ChosQuizCategoryScreen({super.key});

  @override
  State<ChosQuizCategoryScreen> createState() => _ChosQuizCategoryScreenState();
//   Defining the _ChosQuizCategoryScreenState class, which extends the State class for managing the state of the widget.
}

class _ChosQuizCategoryScreenState extends State<ChosQuizCategoryScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  // Inside the state class, two variables _screenWidth and _screenHeight are declared, and they are assigned the width and height of the device screen using MediaQuery.

  String selectedCategory = 'Cat\n1';
  // A variable selectedCategory is defined to keep track of the currently selected category. It is initialized with the value 'Cat\n1'.

  @override
  Widget build(BuildContext context) {
    // Widget build(BuildContext context): This is the build method, which is responsible for building and returning the widget tree. It receives a BuildContext object as an argument, which is typically used to access the theme, localization, and other properties from the widget tree.
    return Scaffold(
      body: SafeArea(
        // The build method is overridden to construct the widget tree for this screen. It returns a Scaffold with a SafeArea as its body.
        child: _bodyView(),
        //   The _bodyView method is defined to build the main content of the screen.
      ),
    );
  }

  Widget _bodyView() {
    return Container(
      height: _screenHeight,
      width: _screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: const BoxDecoration(
        color: AppThemeColor.backGroundColor,
      ),
      // Container with a height and width equal to the screen size. The container has a background color and padding.
      child: Column(
        // Inside the container, there's a Column widget containing the following children:

        children: [
          AppConstents().topBarViewWithBack(context: context),
          // A top bar view with a back button. This is likely a custom widget defined in AppConstents.
          const SizedBox(
            height: 40,
            // A SizedBox with a height of 40 for vertical spacing.
          ),
          const Text(
            'Chose your category',
            style: TextStyle(
              color: AppThemeColor.pureBlackColor,
              fontWeight: FontWeight.w400,
              fontSize: Dimensions.fontSizeLarge,
            ),
            //   A Text widget displaying the message "Chose your category" with specific text styles (color, font weight, and size).
          ),
          const SizedBox(
            height: 40,
            //   A SizedBox with a height of 40 for vertical spacing.
          ),
          Center(
            // A Center widget containing a Container that serves as a button for displaying categories. It has an image icon and the text "Categories" next to it.
            child: Container(
              width: 170,
              decoration: BoxDecoration(
                color: AppThemeColor.pureWhiteColor,
                borderRadius: BorderRadius.circular(7),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
              child: Row(
                children: [
                  Image.asset(
                    'images/categoriesIcon.png',
                    width: 30,
                  ),
                  const SizedBox(
                    width: 10,
                    //   A SizedBox with a width of 10 for horizontal spacing.
                  ),
                  const Text(
                    'Categories',
                    style: TextStyle(
                      color: AppThemeColor.darkBlueColor,
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.fontSizeLarge,
                    ),
                    //   A Text widget displaying the message 'Categories' with specific text styles (color, font weight, and size).
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 40,
            //   A SizedBox with a height of 40 for vertical spacing.
          ),
          _categoriesView(),
          //   The _categoriesView method is defined to build the list of categories displayed as buttons. It uses a Wrap widget to lay out the category buttons in a fluid grid.
        ],
      ),
    );
  }

  Widget _categoriesView() {

    // The Wrap widget contains a list of Container widgets generated from the categoriesList in AppConstents. Each Container represents a category button with an image background and the category name in the center.
    return Wrap( // //Wrap widget, which is used to create a flow of widgets that wrap to the next line when there's not enough horizontal space.
      spacing: 10,
      runSpacing: 10,
      children: AppConstents()
          .categoriesList
          .map(
            (singleCategory) => GestureDetector(
              //When a category is tapped, it calls the singleCategoryScreenRoute method from the RouterClass utility.
              onTap: () => RouterClass().singleCategoryScreenRoute(
                  context: context, selectedCategory: selectedCategory),
              child: Container(
                width: _screenWidth / 4,
                height: _screenWidth / 4,
                decoration: BoxDecoration(
                  //It sets the background image for the category container. Depending on whether the category is selected or not (based on the selectedCategory variable), it loads a blue or gray background image.
                  image: DecorationImage(
                    image: AssetImage(selectedCategory == singleCategory
                        ? 'images/blueCategoryBackground.png'
                        : 'images/grayCategoryBackground.png'),
                  ),
                ),
                child: Center(
                  //The name of the category is displayed using a Text widget. The singleCategory value is used as the text content.
                  child: Text(
                    singleCategory,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppThemeColor.pureBlackColor,
                      fontSize: Dimensions.fontSizeDefault,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            // Each category button is wrapped in a GestureDetector that triggers the navigation to the single category screen when tapped. The RouterClass utility is used for this purpose, and the selectedCategory is passed as an argument to the next screen.
          )
          .toList(),
    );
  }
}
