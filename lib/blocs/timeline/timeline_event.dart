part of 'timeline_bloc.dart';

abstract class TimelineEvent extends Equatable {
  const TimelineEvent();

  @override
  List<Object?> get props => [];
}

class GetCustomerTypeListFromDB extends TimelineEvent {
  const GetCustomerTypeListFromDB();

  @override
  List<Object> get props => [];
}

class GetVisitListFromDB extends TimelineEvent {
  const GetVisitListFromDB({required this.date});

  final String date;

  @override
  List<Object> get props => [date];
}