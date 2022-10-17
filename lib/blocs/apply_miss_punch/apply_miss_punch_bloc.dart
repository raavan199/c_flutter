import 'package:equatable/equatable.dart';

import '../../data/models/miss_punch/miss_punch_item.dart';
import '../../database/db_module.dart';
import '../../exports/models.dart';
import '../base/base_bloc.dart';

part 'apply_miss_punch_event.dart';

part 'apply_miss_punch_state.dart';

class ApplyMissPunchBloc extends BaseBloc<ApplyMissPunchEvent> {
  ApplyMissPunchBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<CallMissPunchApplyApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .applyMissPunchCall(event.missPunchData)
          .then((value) async {
        await apiService.client!
            .getMissPunch(
                MissPunchRequest(pageIndex: 1, missedPunchStatus: null))
            .then((value) {});
        emit(ApplyMissPunchCallSuccessState(data: value));
        print("API Call Success");
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const ApplyMissPunchCallFailState(msg: "API call Fail!"));
        // emit(const PlaceOrderAPICallFailState(msg: "Data Not available!"));
        print("API call fail : ${e.toString()}");
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }
}
