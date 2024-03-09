import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partner/src/models/action_state.dart';
import 'package:partner/src/models/connect_request.dart';
import 'package:partner/src/models/partner.dart';
import 'package:partner/src/utils/enums.dart';
import 'package:uuid/uuid.dart';

class ConnectPartnerProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  //Variables
  ActionState searchState = ActionState();
  ActionState sendRequestState = ActionState();

  //Functions
  void searchPartner(String phone) async {
    //reset send request state too
    sendRequestState = ActionState();
    searchState = searchState.copyWith(state: StateEnum.loading);
    notifyListeners();

    try {
      final query = await _firestore
          .collection("users")
          .where("phone", isEqualTo: "+61$phone")
          .get();

      if (query.docs.isNotEmpty) {
        Partner partner = Partner.fromJson(query.docs.first.data());
        final requestQuery = await _firestore
            .collection("requests")
            .where("senderId", isEqualTo: currentUser?.uid)
            .where(
              "receiverId",
              isEqualTo: partner.id,
            )
            .get();
        if (requestQuery.docs.isNotEmpty) {
          //i.e. already made request in between
          final ConnectRequest request =
              ConnectRequest.fromJson(requestQuery.docs.first.data());
          partner = partner.copyWithRequest(request);
        }
        searchState = searchState.copyWith(
          state: StateEnum.success,
          successData: partner,
        );
        notifyListeners();
      } else {
        searchState = searchState.copyWith(
          state: StateEnum.failed,
          errorMessage: "User doesnot exist with this number",
        );
        notifyListeners();
      }
    } on FirebaseException catch (e) {
      searchState = searchState.copyWith(
        state: StateEnum.failed,
        errorMessage: e.message,
      );
      notifyListeners();
    } catch (e) {
      searchState = searchState.copyWith(
        state: StateEnum.failed,
        errorMessage: "Something went wrong",
      );
      notifyListeners();
    }
  }

  void sendConnectRequest(String userId) async {
    sendRequestState = sendRequestState.copyWith(state: StateEnum.loading);
    notifyListeners();
    try {
      final docId = const Uuid().v1();
      final Map<String, dynamic> requestMap = {
        "id": docId,
        "senderId": FirebaseAuth.instance.currentUser?.uid,
        "receiverId": userId,
        "createdAt": Timestamp.now(),
        "status": RequestStatus.initiate.stringName,
      };
      await _firestore.collection("requests").doc(docId).set(requestMap);
      sendRequestState = sendRequestState.copyWith(
        state: StateEnum.success,
      );
      notifyListeners();
    } catch (e) {
      sendRequestState = sendRequestState.copyWith(
        state: StateEnum.failed,
        errorMessage: "Something went wrong",
      );
      notifyListeners();
    }
  }
}
