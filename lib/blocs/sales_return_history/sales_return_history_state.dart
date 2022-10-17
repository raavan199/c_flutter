part of 'sales_return_history_bloc.dart';

@immutable
abstract class SalesReturnHistoryState extends Equatable {
  const SalesReturnHistoryState();
}

class SalesReturnHistoryInitial extends SalesReturnHistoryState {
  @override
  List<Object> get props => [];
}
//supplier states
class SalesReturnHistorySuccessState extends BaseState {
  const SalesReturnHistorySuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class SalesReturnHistoryFailedState extends BaseState {
  const SalesReturnHistoryFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
