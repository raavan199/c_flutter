
import 'package:equatable/equatable.dart';

import '../../database/db_module.dart';
import '../../resources/app_strings.dart';
import '../base/base_bloc.dart';

part 'warehouse_event.dart';
part 'warehouse_state.dart';

class WarehouseBloc extends BaseBloc<WarehouseEvent> {
  WarehouseBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  static String tag = "WarehouseBloc";

  /// Created by Dev 2136 on 01/12/2022
  /// Modified by Dev 2136 on 01/12/2022
  /// Purpose : on event handler
  void _onEvent() {
    on<GetWarehouseList>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.warehouseDao.getWarehouseDataBasedOnDistributor(event.distributorId).then((value) {
        emit(WarehouseSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const WarehouseFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

}
