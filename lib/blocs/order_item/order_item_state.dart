part of 'order_item_bloc.dart';

@immutable
abstract class OrderItemState extends Equatable{}

class OrderDataSuccessState extends BaseState {
  const OrderDataSuccessState({this.data,this.schemeData});

  final dynamic data;
  final dynamic schemeData;

  @override
  List<Object> get props => <Object>[data,schemeData];
}

class OrderDataFailedState extends BaseState {
  const OrderDataFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class DistributionObjectSuccessState extends BaseState {
  const DistributionObjectSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class DistributionObjectFailedState extends BaseState {
  const DistributionObjectFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}