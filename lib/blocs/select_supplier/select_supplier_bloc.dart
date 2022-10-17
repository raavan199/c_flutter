import 'package:equatable/equatable.dart';

import '../../database/db_module.dart';
import '../../exports/resources.dart';
import '../base/base_bloc.dart';

part 'select_supplier_event.dart';

part 'select_supplier_state.dart';

class SelectSupplierBloc extends BaseBloc<SelectSupplierEvent> {
  SelectSupplierBloc(this.dbModule) : super() {
    _onEvent();
  }

  //variable declaration
  late DBModule dbModule;

  void _onEvent() {
    on<GetSupplierFromDB>((event, emit) async {
      emit(const LoadingState());
      print(queryToGetMultipleSupplier(event.id1, event.id2, event.id3));
      await dbModule.dbInstance.database
          .rawQuery(queryToGetMultipleSupplier(event.id1, event.id2, event.id3))
          .then((value) {
        emit(SupplierSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const SupplierFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

  String queryToGetMultipleSupplier(int id1, int id2, int id3) =>
      'Select * From Distribution where id in ($id1, $id2, $id3)';
}
