part of 'analysis_bloc.dart';

abstract class AnalysisState extends Equatable {
  const AnalysisState();
}

class AnalysisInitial extends AnalysisState {
  @override
  List<Object> get props => [];
}

class CurrentFyDataSuccessState extends BaseState {
  const CurrentFyDataSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class CurrentFyDataFailedState extends BaseState {
  const CurrentFyDataFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class CurrentJcDataSuccessState extends BaseState {
  const CurrentJcDataSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class CurrentJcDataFailedState extends BaseState {
  const CurrentJcDataFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class PrevFyDataSuccessState extends BaseState {
  const PrevFyDataSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class PrevFyDataFailedState extends BaseState {
  const PrevFyDataFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class PrevJcDataSuccessState extends BaseState {
  const PrevJcDataSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class PrevJcDataFailedState extends BaseState {
  const PrevJcDataFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
