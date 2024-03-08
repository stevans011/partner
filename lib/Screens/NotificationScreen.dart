import 'package:flutter/material.dart';

import '../Utils/AppConstents.dart';
import '../Utils/Colors.dart';

//The class NotificationScreen extends StatefulWidget, which means it represents a widget that has mutable state. This allows the widget to change its appearance and behavior over time.
class NotificationScreen extends StatefulWidget {
  //The constructor is defined to create an instance of the NotificationScreen widget. It uses a named parameter key which is passed to the superclass constructor using super.key. Note that the const keyword here indicates that this constructor can be used to create a constant instance of the widget if all its fields are constant.
  const NotificationScreen({super.key});

  @override //The @override annotation indicates that this method is intended to override a method from a superclass, usually from a widget's base class.
  //The createState() method returns an instance of _NotificationScreenState. This method is called when the widget is inserted into the widget tree and creates the associated mutable state for this widget.
  State<NotificationScreen> createState() => _NotificationScreenState();
}

//_NotificationScreenState is a private class the state class associated with the NotificationScreen widget. in short  it is a state that belongs to the NotificationScreen widget.
class _NotificationScreenState extends State<NotificationScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;  //This line defines width of the screen.that uses the current context and then accesses the size.width property to get the screen width.
  late final _screenHeight = MediaQuery.of(context).size.height;  //This line defines height of the screen.that uses the current context and then accesses the size.height property to get the screen height.

  @override //The @override annotation indicates that this method is intended to override a method from a superclass, usually from a widget's base class.
  //The build() is used to define the UI for the widget based on its current state.
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
      decoration: const BoxDecoration(
        color: AppThemeColor.backGroundColor,
      ),
      //Column widget that contains the main content of the screen, arranged vertically.
      child: Column(
        children: [
          //This method defined in the AppConstants class, returns a widget representing the top bar view with a back button or back icon. The context parameter is passed to this method, allowing it to build the appropriate widget.
          AppConstents().topBarViewWithBack(context: context),
          //SizedBox with a height of 40 pixels, creating a vertical space between the top bar view and the rest of the content.
          const SizedBox(
            height: 40,
          ),
          //The Expanded widget takes up the remaining vertically space.
          Expanded(
            //ListView.builder widget, which generates a scrollable list with three items. Each item in the list is created by the _singleNotification function.
            child: ListView.builder(
              itemCount: 3, //specifies that the list will contain number of items.
              // itemBuilder is a callback function that is called for each item in the list. It takes two arguments: contextOfList and index.
              itemBuilder: (contextOfList, index) {
                return _singleNotification(
                    question: 'Notification No ${index + 1}');
              },
            ),
          ),
        ],
      ),
    );
  }

  //_singleNotification function returns a widget that represents a single notification item in the list.
  Widget _singleNotification({required String question}) {

    return Container(
      decoration: BoxDecoration(
        color: AppThemeColor.pureWhiteColor,
        borderRadius: BorderRadius.circular(7),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10), //The container has vertical margin of 10 pixels, providing spacing between this container and other elements.
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7,), //creating space on the vertically and horizontally sides of the content.
      //Row widget, allowing its children to be displayed horizontally in a row.
      child: Row(
        children: [
          // These Image.asset widgets load and display images from the assets of the app with specific width.
          Image.asset(
            'images/notificationIcon.png',
            width: 30,
          ),
          // SizedBox is used to add some spacing horizontally.
          const SizedBox(
            width: 15,
          ),
          //The Expanded widget takes up the remaining horizontal space.
          Expanded(
            //Display question text with specific color
            child: Text(
              question,
              style: const TextStyle(
                color: AppThemeColor.pureBlackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

 /* Widget _topBarView() {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppThemeColor.darkBlueColor,
          ),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        const Icon(
          Icons.notifications_active_outlined,
          color: AppThemeColor.dullFontColor,
        ),
        const SizedBox(
          width: 10,
        ),
        const Icon(
          Icons.menu,
          color: AppThemeColor.dullFontColor,
        ),
      ],
    );
  }*/
}
