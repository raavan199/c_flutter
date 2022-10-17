part of 'apply_miss_punch_bloc.dart';

abstract class ApplyMissPunchEvent extends Equatable {
  const ApplyMissPunchEvent();

  @override
  List<Object?> get props => [];
}


class CallMissPunchApplyApi extends ApplyMissPunchEvent {
  CallMissPunchApplyApi({
    required this.missPunchData
  });

  MissPunchItem missPunchData;

  @override
  List<Object> get props => [
    missPunchData
  ];
}

