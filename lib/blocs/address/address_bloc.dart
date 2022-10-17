import 'package:cygneto/resources/app_strings.dart';
import 'package:equatable/equatable.dart';

import '../../database/db_module.dart';
import '../base/base_bloc.dart';

part 'address_event.dart';

part 'address_state.dart';

class AddressBloc extends BaseBloc<AddressEvent> {
  AddressBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<GetCountryEvent>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.countryDao.getCountryData().then((value) {
        emit(CountryInAddressSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const CountryInAddressFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetStatesBaseOnCountryEvent>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.database
          .rawQuery(_queryToGetStateBasedOnDefaultCountryId())
          .then((value) {
        emit(StateInAddressSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const StateInAddressFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetDistrictsBaseOnStateEvent>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.districtDao
          .getDistrictBasedOnStateId(event.id)
          .then((value) {
        emit(DistrictInAddressSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const DistrictInAddressFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetLocationBasedOnDistrictEvent>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.locationDao
          .getLocationBasedOnDistrictId(event.id)
          .then((value) {
        emit(LocationInAddressSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const LocationInAddressFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

  String _queryToGetStateBasedOnDefaultCountryId() {
    return "select sd.* from statedata as sd "
        "inner join country as c on c.isDefault=1 "
        "where country_id=c.id";
  }
}
