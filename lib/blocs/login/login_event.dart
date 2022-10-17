part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  const LoginButtonPressed({
    required this.mobileNumber,
    required this.pin,
  });

  final String mobileNumber;
  final String pin;

  @override
  List<Object> get props => [mobileNumber, pin];

  @override
  String toString() =>
      'LoginButtonPressed { email: $mobileNumber, password: $pin }';
}

