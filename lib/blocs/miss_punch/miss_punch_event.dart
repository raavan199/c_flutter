part of 'miss_punch_bloc.dart';

abstract class MissPunchEvent extends Equatable {
  const MissPunchEvent();

  @override
  List<Object?> get props => [];
}

class CallMissPunchAPI extends MissPunchEvent {
  const CallMissPunchAPI(
      {required this.pageIndex, required this.missedPunchStatus});

  final int pageIndex;
  final int? missedPunchStatus;

  @override
  List<Object> get props => [pageIndex, missedPunchStatus!];

}

