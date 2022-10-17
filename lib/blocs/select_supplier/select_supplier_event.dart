part of 'select_supplier_bloc.dart';

abstract class SelectSupplierEvent extends Equatable {
  const SelectSupplierEvent();

  @override
  List<Object?> get props => [];
}

class GetSupplierFromDB extends SelectSupplierEvent {
  const GetSupplierFromDB(this.id1, this.id2, this.id3);

  final int id1;
  final int id2;
  final int id3;

  @override
  List<Object> get props => [id1, id2, id3];
}
