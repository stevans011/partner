// ignore_for_file: public_member_api_docs, sort_constructors_first
enum StateEnum { initial, loading, success, failed }

extension StateEnumX on StateEnum {
  bool get isInitial => this == StateEnum.initial;
  bool get isLoading => this == StateEnum.loading;
  bool get isSuccess => this == StateEnum.success;
  bool get isFailed => this == StateEnum.failed;
}

class ActionState {
  final StateEnum state;
  final String errorMessage;
  final dynamic successData;

  ActionState({
    this.state = StateEnum.initial,
    this.errorMessage = "",
    this.successData,
  });

  ActionState copyWith({
    StateEnum? state,
    String? errorMessage,
    dynamic successData,
  }) {
    return ActionState(
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
      successData: successData ?? this.successData,
    );
  }
}
