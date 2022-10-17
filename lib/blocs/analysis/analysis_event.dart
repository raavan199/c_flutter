part of 'analysis_bloc.dart';

abstract class AnalysisEvent extends Equatable {
  const AnalysisEvent();

  @override
  List<Object?> get props => [];
}

class GetCurrentFyDataFromDatabaseEvent extends AnalysisEvent {
  const GetCurrentFyDataFromDatabaseEvent({
    required this.customerId,
  });

  final int customerId;

  @override
  List<Object> get props => [customerId];
}

class GetCurrentJcData extends AnalysisEvent {
  const GetCurrentJcData({
    required this.customerId,
    required this.currentDate,
  });

  final int customerId;
  final String currentDate;

  @override
  List<Object> get props => [customerId];
}

class GetPrevFyData extends AnalysisEvent {
  const GetPrevFyData({
    required this.customerId,
    required this.currentDate,
  });

  final int customerId;
  final String currentDate;

  @override
  List<Object> get props => [customerId];
}

class GetPrevJcData extends AnalysisEvent {
  const GetPrevJcData({
    required this.customerId,
    required this.currentDate,
  });

  final int customerId;
  final String currentDate;

  @override
  List<Object> get props => [customerId];
}
