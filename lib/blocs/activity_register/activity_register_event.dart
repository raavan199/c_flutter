part of 'activity_register_bloc.dart';

abstract class ActivityRegisterEvent extends Equatable {
  const ActivityRegisterEvent();

  @override
  List<Object> get props => [];
}

class GetActivityRegisterTypesFromDB extends ActivityRegisterEvent {
  const GetActivityRegisterTypesFromDB();

  @override
  List<Object> get props => [];
}

class InsertActivityRegisterIntoDB extends ActivityRegisterEvent {
  const InsertActivityRegisterIntoDB({
    required this.activityData
  });

  final ActivityRegisteredItem activityData;

  @override
  List<Object> get props => [
    activityData
  ];
}

class GetUnSyncActivityRegister extends ActivityRegisterEvent {
  const GetUnSyncActivityRegister();

  @override
  List<Object> get props => [];
}