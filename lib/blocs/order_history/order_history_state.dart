part of 'order_history_bloc.dart';

abstract class OrderHistoryState extends Equatable {
  const OrderHistoryState();

  @override
  List<Object?> get props => [];
}

class GetOrderRecordListSuccessState extends BaseState {
  const GetOrderRecordListSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetOrderRecordListFailState extends BaseState {
  const GetOrderRecordListFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}