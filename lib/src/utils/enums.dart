enum RequestStatus { initiate, accepted, rejected }

extension RequestStatusX on RequestStatus {
  bool get isInitiate => this == RequestStatus.initiate;
  bool get isAccepted => this == RequestStatus.accepted;
  bool get isRejected => this == RequestStatus.rejected;

  String get stringName {
    if (isAccepted) {
      return "Accepted";
    } else if (isRejected) {
      return 'Rejected';
    } else {
      return "Initiated";
    }
  }
}

extension RequestStatusStringX on String {
  RequestStatus get requestStatus {
    if (this == "Accepted") {
      return RequestStatus.accepted;
    } else if (this == "Rejected") {
      return RequestStatus.rejected;
    } else {
      return RequestStatus.initiate;
    }
  }
}
