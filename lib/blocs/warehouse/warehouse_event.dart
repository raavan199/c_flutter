part of 'warehouse_bloc.dart';

abstract class WarehouseEvent extends Equatable {
  const WarehouseEvent();

  @override
  List<Object?> get props => [];
}

class GetWarehouseList extends WarehouseEvent {
  const GetWarehouseList({
    required this.distributorId,
  });

  final int distributorId;

  @override
  List<Object> get props => [distributorId];

  @override
  String toString() => '''
SendOtpButtonPressed { distributorId: $distributorId }''';
}
