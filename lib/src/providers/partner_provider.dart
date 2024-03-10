import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:partner/src/models/action_state.dart';
import 'package:partner/src/models/connect_request.dart';
import 'package:partner/src/models/partner.dart';
import 'package:partner/src/utils/enums.dart';

class PartnerProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  //Variables
  ActionState getPartnersState = ActionState();

  //Getters
  Partner? get lastConnectedPartner {
    if (getPartnersState.state.isSuccess) {
      List<Partner> partners = getPartnersState.successData as List<Partner>;
      if (partners.isNotEmpty) {
        return partners.last;
      } else {
        return null;
      }
    }
    return null;
  }

  //Functions

  void getPartners() async {
    getPartnersState = getPartnersState.copyWith(state: StateEnum.loading);
    notifyListeners();

    try {
      final requestQuery = await _firestore
          .collection("requests")
          .where(Filter.or(Filter("senderId", isEqualTo: _currentUser?.uid),
              Filter("receiverId", isEqualTo: _currentUser?.uid)))
          .where("status", isEqualTo: RequestStatus.accepted.stringName)
          .get();
      List<ConnectRequest> requests = List<ConnectRequest>.from(
          requestQuery.docs.map((e) => ConnectRequest.fromJson(e.data())));

      List<Partner> partners = [];
      for (var request in requests) {
        if (request.senderId != _currentUser?.uid) {
          final userQuery =
              await _firestore.collection("users").doc(request.senderId).get();
          if (userQuery.exists) {
            Partner partner = Partner.fromJson(userQuery.data()!);
            partners.add(partner);
          }
        }
        if (request.receiverId != _currentUser?.uid) {
          final userQuery = await _firestore
              .collection("users")
              .doc(request.receiverId)
              .get();
          if (userQuery.exists) {
            Partner partner = Partner.fromJson(userQuery.data()!);
            partners.add(partner);
          }
        }
      }

      getPartnersState = getPartnersState.copyWith(
        state: StateEnum.success,
        successData: partners,
      );
      notifyListeners();
    } catch (e) {
      getPartnersState = getPartnersState.copyWith(
        state: StateEnum.failed,
        errorMessage: "Something went wrong",
      );
    }
  }
}
