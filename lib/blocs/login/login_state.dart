part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends BaseState {
  const LoginSuccessState({required this.pin, this.data});

  final dynamic data;
  final String pin;

  @override
  List<Object> get props => <Object>[data, pin];
}

class LoginFailedState extends BaseState {
  const LoginFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class PinHashSuccessState extends BaseState {
  const PinHashSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class PinHashFailedState extends BaseState {
  const PinHashFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
