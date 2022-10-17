
import 'package:equatable/equatable.dart';

import '../../data/models/miss_punch/miss_punch_request.dart';
import '../../database/db_module.dart';
import '../base/base_bloc.dart';

part 'miss_punch_event.dart';
part 'miss_punch_state.dart';

class MissPunchBloc extends BaseBloc<MissPunchEvent> {
  MissPunchBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<CallMissPunchAPI>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getMissPunch(MissPunchRequest(
        pageIndex: event.pageIndex,
        missedPunchStatus: event.missedPunchStatus
      ))
          .then((value) {
        emit(CallMissPunchAPISuccessState(data: value.data!.items));
        print("API Call Success");
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const CallMissPunchAPIFailedState(msg: "Data Not available!"));
        print("API call fail : ${e.toString()}");
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }
}
