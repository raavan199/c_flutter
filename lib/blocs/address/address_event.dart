part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object?> get props => [];
}

class GetCountryEvent extends AddressEvent {
  const GetCountryEvent();
  @override
  List<Object> get props => [];
}

class GetStatesBaseOnCountryEvent extends AddressEvent {
  const GetStatesBaseOnCountryEvent({
    required this.id,
  });

  final int id;

  @override
  List<Object> get props => [id];
}

class GetDistrictsBaseOnStateEvent extends AddressEvent {
  const GetDistrictsBaseOnStateEvent({
    required this.id,
  });

  final int id;

  @override
  List<Object> get props => [];
}

class GetLocationBasedOnDistrictEvent extends AddressEvent {
  const GetLocationBasedOnDistrictEvent({
    required this.id,
  });

  final int id;

  @override
  List<Object> get props => [];
}
