part of 'miss_punch_bloc.dart';

abstract class MissPunchState extends Equatable {
  const MissPunchState();

  @override
  List<Object?> get props => [];
}
class CallMissPunchAPISuccessState extends BaseState {
  const CallMissPunchAPISuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class CallMissPunchAPIFailedState extends BaseState {
  const CallMissPunchAPIFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}