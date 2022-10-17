part of 'customer_bloc.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();
}

class CustomerInitial extends CustomerState {
  @override
  List<Object> get props => [];
}

//state states
class GetCustomersSuccessState extends BaseState {
  const GetCustomersSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetCustomersFailedState extends BaseState {
  const GetCustomersFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetRoutesCountSuccessState extends BaseState {
  const GetRoutesCountSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}
