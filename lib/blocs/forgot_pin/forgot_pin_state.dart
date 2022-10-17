part of 'forgot_pin_bloc.dart';

abstract class ForgotPinState extends Equatable {
  const ForgotPinState();
}

class ForgotPinInitial extends ForgotPinState {
  @override
  List<Object> get props => [];
}

class ResendOtpSuccessState extends BaseState {
  const ResendOtpSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class ResendOtpFailedState extends BaseState {
  const ResendOtpFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class VerifyOtpSuccessState extends BaseState {
  const VerifyOtpSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class VerifyOtpFailedState extends BaseState {
  const VerifyOtpFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
