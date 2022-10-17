part of 'reset_pin_bloc.dart';

abstract class ResetPinEvent extends Equatable {
  const ResetPinEvent();

  @override
  List<Object?> get props => [];
}

class ResetPinButtonPressed extends ResetPinEvent {
  const ResetPinButtonPressed({
    required this.mobileNumber,
    required this.pin,
  });

  final String mobileNumber;
  final String pin;

  @override
  List<Object> get props => [mobileNumber, pin];

  @override
  String toString() =>
      'ResetPinButtonPressed { mobileNumber: $mobileNumber, pin: $pin }';
}
