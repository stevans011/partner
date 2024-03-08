import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:partner/Objects/FullUserObject.dart';

import '../Objects/UserObject.dart';

// Dart class named FirebaseDatabaseHelper that interacts with Firebase Realtime Database to fetch user data.
class FirebaseDatabaseHelper {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance; //this is used to create an instance of the FirebaseDatabase class. This instance represents the entry point for accessing Firebase Realtime Database.

  // This method retrieves a single UserObject associated with the current user's UID. It queries the 'Users' node with the user's UID and converts the fetched data into a UserObject using the fromJson method.
  Future<UserObject?> getUsers() async {
    UserObject? candidateObject; //This declares a variable candidateObject of type UserObject?. It will hold the user data retrieved from the database.

    //This line creates a reference to the database location where the user data is stored. It uses the FirebaseDatabase.instance.ref() method to specify the path, which, in this case, is the 'Users' node, and it appends the current user's UID to the path using .child(FirebaseAuth.instance.currentUser!.uid).
    final topUserPostsRef = FirebaseDatabase.instance
        .ref('Users')
        .child(FirebaseAuth.instance.currentUser!.uid);

    //This block is a try-catch block that handles potential errors that might occur during the database query.
    try {
      await topUserPostsRef.once().then((snapshot) { //This line is responsible for fetching data from the database. It uses the once() method to read the data at the specified database reference. The await keyword is used to wait for the asynchronous operation to complete before continuing.
        Map<dynamic, dynamic>? value =  snapshot.snapshot.value as Map<dynamic, dynamic>?; //This line captures the data retrieved from the database as a Map<dynamic, dynamic>? object. The snapshot.snapshot.value contains the raw data from the database.

        //This condition checks if the retrieved data (value) is not null. If the data exists, it uses the fromJson method of the UserObject class to convert the raw data into a meaningful UserObject.
        if (value != null) {
          candidateObject = UserObject.fromJson(value);
        }
      });
      return candidateObject;
    }
    //If any error occurs during the data fetching or conversion process, it will be caught here, and the error message will be printed using print().The method will then return null.
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  //This method retrieves a single UserObject associated with a given phone number. It queries the 'Users' node using the 'phoneNumber' attribute and converts the fetched data into a UserObject.
  Future<UserObject?> getUsersByPhoneNumber(
      {required String phoneNumber}) async {
    UserObject? candidateObject; //This declares a variable candidateObject of type UserObject?. It will hold the user data retrieved from the database.

    // This line creates a reference to the database location where the user data is stored. It uses the FirebaseDatabase.instance.ref() method to specify the path, which, in this case, is the 'Users' node. Additionally, it applies filtering to the query using .orderByChild('phoneNumber').equalTo(phoneNumber) to retrieve only the data that matches the provided phone number.
    final topUserPostsRef = FirebaseDatabase.instance
        .ref('Users')
        .orderByChild('phoneNumber')
        .equalTo(
          phoneNumber,
        );
    // try {
    await topUserPostsRef.once().then((snapshot) { // This line is responsible for fetching data from the database based on the applied query.
      Map<dynamic, dynamic>? value =
      snapshot.snapshot.value as Map<dynamic, dynamic>?; //This line captures the data retrieved from the database as a Map<dynamic, dynamic>? object. The snapshot.snapshot.value contains the raw data from the database.

      //This condition checks if the retrieved data (value) is not null. If the data exists, it iterates through the value map using forEach and converts each user's data into a UserObject. The candidateObject will be assigned the value of the last converted UserObject.
      if (value != null) {
        value.forEach((key, userValue) {
          candidateObject = UserObject.fromJson(userValue);
        });
      } else {
        return null;
      }
    });
    return candidateObject; // If the data is successfully retrieved and converted into a UserObject, the method returns the candidateObject. Otherwise, it will return null
    // } catch (e) {
    //   print(e.toString());
    //   return null;
    // }
  }

  //This method retrieves a single FullUserObject associated with the current user's UID. It queries the 'FullUserProfiles' node with the user's UID and converts the fetched data into a FullUserObject using the fromJson method.
  Future<FullUserObject?> getFullUsers() async {
    FullUserObject? candidateObject; //this is used to create an instance of the FirebaseDatabase class. This instance represents the entry point for accessing Firebase Realtime Database.

    //This line creates a reference to the database location where the full user data is stored. It uses the FirebaseDatabase.instance.ref() method to specify the path, which in this case, is the 'FullUserProfiles' node, and it appends the current user's UID to the path using .child(FirebaseAuth.instance.currentUser!.uid).
    final topUserPostsRef = FirebaseDatabase.instance
        .ref('FullUserProfiles')
        .child(FirebaseAuth.instance.currentUser!.uid);
    //This block is a try-catch block that handles potential errors that might occur during the database query.
    try {
      await topUserPostsRef.once().then((snapshot) { //This line is responsible for fetching data from the database. It uses the once() method to read the data at the specified database reference. The await keyword is used to wait for the asynchronous operation to complete before continuing.
        Map<dynamic, dynamic>? value = snapshot.snapshot.value as Map<dynamic, dynamic>?;

        //This condition checks if the retrieved data (value) is not null. If the data exists, it uses the fromJson method of the UserObject class to convert the raw data into a meaningful UserObject.
        if (value != null) {
          candidateObject = FullUserObject.fromJson(value);
        }
      });

      return candidateObject;
    }
    //If any error occurs during the data fetching or conversion process, it will be caught here, and the error message will be printed using print().The method will then return null.
    catch (e) {
      print(e.toString());
      return null;
    }
  }
}
