import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partner/src/services/auth_service.dart';
import 'package:partner/src/utils/exception.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  // State Variables
  bool isLoginLoading = false;
  String? loginError;
  bool verifyPhoneLoading = false;
  String? verifyPhoneError;
  String? verificationId;
  bool userAlreadyExist = false;

  bool profileSetupLoading = false;
  bool profileSetupSuccess = false;

  void login(String pin) async {
    isLoginLoading = true;
    notifyListeners();

    try {
      final user = await _authService.loginWithPhone(pin, verificationId!);
      if (user != null) {
        final userRef = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();
        if (userRef.exists) {
          // User already setup
          userAlreadyExist = true;
          isLoginLoading = false;
          notifyListeners();
        } else {
          // Setup user profile
          setUpUserProfile(user);
          userAlreadyExist = false;
          isLoginLoading = false;
          notifyListeners();
        }
      }
    } on CustomException catch (e) {
      loginError = e.message;
      isLoginLoading = false;
      notifyListeners();
    } catch (e) {
      loginError = "Unknown Error";
      isLoginLoading = false;
      notifyListeners();
    }
  }

  void verifyPhone(String phone) async {
    verifyPhoneLoading = true;
    notifyListeners();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+61$phone",
      verificationCompleted: (credential) {},
      codeSent: (verificationId, resendingToken) {
        verifyPhoneLoading = false;
        this.verificationId = verificationId;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      verificationFailed: (exception) {
        verifyPhoneLoading = false;
        verifyPhoneError = exception.message ?? "Unknown error";
        notifyListeners();
      },
    );
  }

  void setUpUserProfile(User user) async {
    await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      "id": user.uid,
      "phone": user.phoneNumber,
      "createdAt": Timestamp.now(),
    });
  }

  void updateProfileDetail({
    String? username,
    String? name,
    String? dob,
  }) async {
    profileSetupLoading = true;
    notifyListeners();
    final currentUser = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser?.uid)
          .update({
        "name": name,
        "username": username,
        "dob": dob,
      });
      profileSetupLoading = false;
      profileSetupSuccess = true;
      notifyListeners();
    } catch (e) {
      profileSetupLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
