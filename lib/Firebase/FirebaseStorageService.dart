import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService {
  static final FirebaseStorage firebaseStorage = FirebaseStorage.instance; //creates a static final variable firebaseStorage of type FirebaseStorage. It initializes this variable with the singleton instance of FirebaseStorage obtained using FirebaseStorage.instance.

//  Reference storageReference = firebaseStorage.getR();
  Reference storageReference = FirebaseStorage.instance.ref(); // initializes a variable storageReference of type Reference with a reference to the root of the Firebase Storage bucket.


  // this method is designed to upload an image file to Firebase Storage.
  Future<UploadTask?> uploadImage({
    required XFile file, //An object of type XFile, representing the image file that needs to be uploaded. XFile is commonly used in Flutter for file handling, and it represents a cross-platform file path.
    required Reference ref, //A Reference representing the destination location in Firebase Storage where the image will be uploaded.
  }) async {
    UploadTask uploadTask;

    // Create a Reference to the file
//This metadata is optional but can be used to set properties for the uploaded file. In this case, it sets the contentType to indicate that the image is in JPEG or PNG format, and it also sets a custom metadata field called 'picked-file-path' to store the local file path from which the image was selected.
    final metadata = SettableMetadata(
      contentType: 'image/jpeg/png',
      customMetadata: {'picked-file-path': file.path},
    );

//The method checks if the current platform is web. If the platform is web.
    if (kIsWeb) { // kIsWeb is a constant variable typically provided by the Flutter framework that is true when running on the web platform.
      uploadTask = ref.putData(await file.readAsBytes(), metadata); //the method will upload the image data as bytes using putData method on the ref. This is because web platforms do not have access to local file paths due to security restrictions.
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata); //If the platform is not web, the method will upload the image file using the putFile method on the ref. For this, it uses the io.File class to handle the local file path
    }

    return Future.value(uploadTask);
  }
}
