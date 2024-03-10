import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:partner/src/models/action_state.dart';
import 'package:partner/src/models/connect_request.dart';
import 'package:partner/src/models/partner.dart';
import 'package:partner/src/utils/enums.dart';

class ConnectRequestProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  //Variables
  ActionState getConnectRequestsState = ActionState();

  // Get all partner connect requests
  void getConnectRequestsForMe() async {
    final userId = currentUser?.uid;
    getConnectRequestsState =
        getConnectRequestsState.copyWith(state: StateEnum.loading);
    notifyListeners();

    try {
      final requestsQuery = await _firestore
          .collection("requests")
          .where("receiverId", isEqualTo: userId)
          .where("status", isEqualTo: RequestStatus.initiate.stringName)
          .get();
      final List<ConnectRequest> requests = List<ConnectRequest>.from(
          requestsQuery.docs.map((e) => ConnectRequest.fromJson(e.data())));
      for (var request in requests) {
        final partnerQuery =
            await _firestore.collection("users").doc(request.senderId).get();
        if (partnerQuery.exists) {
          Partner partner = Partner.fromJson(partnerQuery.data()!);
          request = request.copyWith(sender: partner);
          int updateIndex =
              requests.indexWhere((element) => element == request);
          requests[updateIndex] = request;
        }
      }
      getConnectRequestsState = getConnectRequestsState.copyWith(
        state: StateEnum.success,
        successData: requests,
      );
      notifyListeners();
    } catch (e) {
      getConnectRequestsState = getConnectRequestsState.copyWith(
        state: StateEnum.failed,
        errorMessage: "Something went wrong",
      );
      notifyListeners();
    }
  }

  // handle accept or rejection
  void respondRequest(RequestStatus status, ConnectRequest request) async {
    try {
      await _firestore
          .collection("requests")
          .doc(request.id)
          .update({"status": status.stringName});
      getConnectRequestsForMe();
    } catch (e) {}
  }
}
