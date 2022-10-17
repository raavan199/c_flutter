import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cygneto/blocs/base/base_bloc.dart';
import 'package:cygneto/database/db_module.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends BaseBloc<FilterEvent> {

  late DBModule dbModule;

  FilterBloc(this.dbModule):super(){
     _onEvent();
  }
  _onEvent(){
    ///group data
    on<GetGroupListFromDB>((event, emit) async{
      emit(const LoadingState());
      await dbModule.dbInstance.productGroupDao.getParentGroupData().then((value){
        emit(FilterGroupSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const FilterGroupFailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///sub group data
    on<GetSubGroupListFromDB>((event, emit) async{
      emit(const LoadingState());
      await dbModule.dbInstance.productGroupDao.getSubGroupData(event.id).then((value){
        emit(FilterSubGroupSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const FilterSubGroupFailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///category data
    on<GetCategoryListFromDB>((event, emit) async{
      emit(const LoadingState());
      await dbModule.dbInstance.productCategoryDao.getParentCategoryData().then((value){
        emit(FilterCategorySuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const FilterCategoryFailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///sub category data
    on<GetSubCategoryListFromDB>((event, emit) async{
      emit(const LoadingState());
      await dbModule.dbInstance.productCategoryDao.getSubCategoryData(event.id).
      then((value){
        emit(FilterSubCategorySuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const FilterSubCategoryFailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }
}
