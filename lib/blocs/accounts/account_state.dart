part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();
}

class AccountInitial extends AccountState {
  @override
  List<Object> get props => [];
}

class GetInvoicesSuccessState extends BaseState {
  const GetInvoicesSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetInvoicesFailedState extends BaseState {
  const GetInvoicesFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetTopLayoutDataSuccessState extends BaseState {
  const GetTopLayoutDataSuccessState(
      {required this.openingBalance,
      required this.newBilling,
      required this.paymentAdjustment});

  final double openingBalance;
  final double newBilling;
  final double paymentAdjustment;

  @override
  List<Object> get props =>
      <Object>[openingBalance, newBilling, paymentAdjustment];
}
