import 'package:cygneto/data/models/customer/customer_address_response.dart';
import 'package:cygneto/data/models/customer/customer_data_items_response.dart';
import 'package:cygneto/resources/app_strings.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../database/db_module.dart';
import '../base/base_bloc.dart';

part 'modify_outlet_event.dart';

part 'modify_outlet_state.dart';

class ModifyOutletBloc extends BaseBloc<ModifyOutletEvent> {
  ModifyOutletBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<GetCustomerTypeFromDBEvent>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.customerTypeDao.getCustomerData().then((value) {
        emit(GetCustomerTypeFromDBSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetCustomerTypeFromDBFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetCustomerCategoryFromDBEvent>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.customerCategoryDao
          .getCustomerCategoryData()
          .then((value) {
        emit(GetCustomerCategoryFromDBSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetCustomerCategoryFromDBFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetSupplierInOutletFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.distributionDao
          .getDistributionData()
          .then((value) {
        emit(SupplierInOutletSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const SupplierInOutletFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetRouteListFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.routeDao.getAllData().then((value) {
        emit(RouteSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const RouteFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<AddOutlet>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .addOutlet(event.customerDataItemsResponse)
          .then((value) {
        emit(SuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(FailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<UpdateCustomerTable>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.customerDao
          .insertCustomerData(event.customerDataItemsResponse)
          .then((value) {
        _updateAddressTable(event.customerDataItemsResponse.customerAddress!);
      }).catchError((e) {
        emit(const UpdateCustomerTableFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

  _updateAddressTable(List<CustomerAddressResponse> addressList) async {
      emit(const LoadingState());
      await dbModule.dbInstance.customerAddressDao
          .insertCustomerAddressData(addressList)
          .then((value) {
        emit(const UpdateCustomerTableSuccessState());
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const UpdateCustomerTableFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
  }
}
