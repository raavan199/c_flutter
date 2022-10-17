part of 'apply_miss_punch_bloc.dart';

abstract class ApplyMissPunchState extends Equatable {
  const ApplyMissPunchState();

  @override
  List<Object?> get props => [];
}

class ApplyMissPunchCallSuccessState extends BaseState {
  const ApplyMissPunchCallSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class ApplyMissPunchCallFailState extends BaseState {
  const ApplyMissPunchCallFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
