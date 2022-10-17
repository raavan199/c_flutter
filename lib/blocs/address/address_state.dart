part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();
}

class AddressInitial extends AddressState {
  @override
  List<Object> get props => [];
}

class CountryInAddressSuccessState extends BaseState {
  const CountryInAddressSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class CountryInAddressFailedState extends BaseState {
  const CountryInAddressFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class StateInAddressSuccessState extends BaseState {
  const StateInAddressSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class StateInAddressFailedState extends BaseState {
  const StateInAddressFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class DistrictInAddressSuccessState extends BaseState {
  const DistrictInAddressSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class DistrictInAddressFailedState extends BaseState {
  const DistrictInAddressFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class LocationInAddressSuccessState extends BaseState {
  const LocationInAddressSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class LocationInAddressFailedState extends BaseState {
  const LocationInAddressFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
