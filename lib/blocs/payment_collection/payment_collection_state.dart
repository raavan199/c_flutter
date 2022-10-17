part of 'payment_collection_bloc.dart';

abstract class PaymentCollectionState extends Equatable {
  const PaymentCollectionState();
}

class PaymentCollectionInitial extends PaymentCollectionState {
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

class PostInvoiceStatementSuccessState extends BaseState {
  const PostInvoiceStatementSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class PostInvoiceStatementFailedState extends BaseState {
  const PostInvoiceStatementFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
class LatestInvoiceStatementSuccessState extends BaseState {
  const LatestInvoiceStatementSuccessState({this.latestInvoiceStatement,this.approvedSalesReturn});

  final dynamic latestInvoiceStatement;
  final dynamic approvedSalesReturn;

  @override
  List<Object> get props => <Object>[latestInvoiceStatement,approvedSalesReturn];
}

class LatestInvoiceStatementFailedState extends BaseState {
  const LatestInvoiceStatementFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}