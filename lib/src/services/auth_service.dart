import 'package:firebase_auth/firebase_auth.dart';
import 'package:partner/src/utils/exception.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> loginWithPhone(String pin, String verificationId) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: pin);
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseException catch (e) {
      throw CustomException(e.message ?? "Something went wrong");
    } catch (e) {
      throw CustomException("Unknown Error");
    }
  }

  Future<String?> verifyNumber(String phone) async {
    try {
      String? id;
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (credential) {},
        codeSent: (verificationId, resendingToken) {
          id = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: const Duration(seconds: 60),
        verificationFailed: (exception) {
          throw CustomException(
            exception.message ?? "Something weng wrong in verification",
          );
        },
      );
      return id;
    } on FirebaseException catch (e) {
      throw CustomException(e.message ?? "Something went wrong");
    } catch (e) {
      throw CustomException("Unknown Error");
    }
  }
}
