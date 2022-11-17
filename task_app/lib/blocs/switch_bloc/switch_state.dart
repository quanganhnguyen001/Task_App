part of 'switch_bloc.dart';

class SwitchState extends Equatable {
  const SwitchState({required this.switchValue});
  final bool switchValue;

  @override
  List<Object> get props => [switchValue];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'switchValue': switchValue});

    return result;
  }

  factory SwitchState.fromMap(Map<String, dynamic> map) {
    return SwitchState(
      switchValue: map['switchValue'] ?? false,
    );
  }
}

class SwitchInitial extends SwitchState {
  SwitchInitial({required bool switchValue}) : super(switchValue: switchValue);
}
