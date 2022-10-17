part of 'forgot_pin_bloc.dart';

abstract class ForgotPinEvent extends Equatable {
  const ForgotPinEvent();

  @override
  List<Object?> get props => [];
}

class SendOtpButtonPressed extends ForgotPinEvent {
  const SendOtpButtonPressed({
    required this.mobileNumber,
    required this.forgotPinApiType,
  });

  final String mobileNumber;
  final ForgotPinApiType forgotPinApiType;

  @override
  List<Object> get props => [mobileNumber, forgotPinApiType];

  @override
  String toString() => '''
SendOtpButtonPressed { mobileNumber: $mobileNumber, forgotPinApiType: $forgotPinApiType }''';
}

class VerifyOtpButtonPressed extends ForgotPinEvent {
  const VerifyOtpButtonPressed({
    required this.mobileNumber,
    required this.otp,
  });

  final String mobileNumber;
  final String otp;

  @override
  List<Object> get props => [mobileNumber, otp];

  @override
  String toString() =>
      'VerifyOtpButtonPressed { mobileNumber: $mobileNumber, otp: $otp }';
}
