part of 'activity_history_bloc.dart';

abstract class ActivityHistoryEvent extends Equatable {
  const ActivityHistoryEvent();

  @override
  List<Object> get props => [];
}

class GetActivityHistory extends ActivityHistoryEvent {
  const GetActivityHistory({
    required this.startDate,
    required this.endDate});
  final String startDate;
  final String endDate;
  @override
  List<Object> get props => [startDate,endDate];
}

class ManageActivityRegisterCall extends ActivityHistoryEvent {
  const ManageActivityRegisterCall({
    required this.data});
  final ActivityRegisteredItem data;
  @override
  List<Object> get props => [data];
}

class DeleteActivityAPICall extends ActivityHistoryEvent {
  const DeleteActivityAPICall({
    required this.id});
  final int id;
  @override
  List<Object> get props => [id];
}

class DeleteActivityById extends ActivityHistoryEvent {
  const DeleteActivityById({
    required this.id});
  final int id;
  @override
  List<Object> get props => [id];
}
