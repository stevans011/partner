
//The class represents a user object with four required properties: uid, userName, password, and phoneNumber.
class UserObject {
  String uid, userName, password, phoneNumber;

  //The class has a constructor  that allows initializing the properties with required named parameters.
  //When creating a UserObject instance, you must provide values for this all field.
  UserObject({
    required this.uid,
    required this.userName,
    required this.password,
    required this.phoneNumber,
  });

//The class has a factory method called fromJson, which takes a Map<dynamic, dynamic> as input (usually received from a JSON response).
  //This factory method is responsible for converting the JSON data into a UserObject instance.
  factory UserObject.fromJson(Map<dynamic, dynamic> json) {
    print('user DATA GETTING $json');
    // print('user DATA GETTING ${json['uid']}');
    return UserObject(
      uid: json['uid'],
      userName: json['userName'],
      phoneNumber: json['phoneNumber'] ?? '',
      password: json['password'] ?? '',
    );
  }

  //The class has a method called toJson, which converts the UserObject instance into a JSON-formatted map.
//This method is useful when you need to send the user object as JSON data in an API request or save it to a database.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['uid'] = uid;
    data['userName'] = userName;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
