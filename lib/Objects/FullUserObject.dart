import 'package:image_picker/image_picker.dart'; //this package is used to pick images from the device's gallery or camera.

//The class represents a user object with several properties related to a user profile.
class FullUserObject {
  String? uid, userName, phoneNumber;

  String? imageLink, firstName, dob;
  String? imageName;
  XFile? imageFile;

  //The class has a constructor  that allows initializing the properties with optional named parameters.
  FullUserObject({
    this.uid,
    this.userName,
    this.phoneNumber,
    this.firstName,
    this.dob,
    this.imageLink,
    this.imageName,
    this.imageFile,
  });

  //The class has a factory method called fromJson, which takes a Map<dynamic, dynamic> as input (usually received from a JSON response).
  factory FullUserObject.fromJson(Map<dynamic, dynamic> json) {
    print('user DATA GETTING $json');
    //This factory method is responsible for converting the JSON data into a FullUserObject instance.
    return FullUserObject(
      uid: json['uid'],
      userName: json['userName'],
      phoneNumber: json['phoneNumber'] ?? '',
      imageLink: json['imageLink'] ?? '',
      dob: json['dob'] ?? '',
      firstName: json['firstName'] ?? '',
    );
  }

  //The class has a method called toJson, which converts the FullUserObject instance into a JSON-formatted map.
  //This method is useful when you need to send the user object as JSON data in an API request or save it to a database.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['uid'] = uid;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['phoneNumber'] = phoneNumber;
    data['imageLink'] = imageLink;
    data['dob'] = dob;
    return data;
  }
}
