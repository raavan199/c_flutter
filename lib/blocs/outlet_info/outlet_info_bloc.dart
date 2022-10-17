import 'package:equatable/equatable.dart';

import '../../database/db_module.dart';
import '../../exports/models.dart';
import '../base/base_bloc.dart';

part 'outlet_info_event.dart';
part 'outlet_info_state.dart';

class OutletInfoBloc extends BaseBloc<OutletInfoEvent> {
  OutletInfoBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<UpdateVisitPunchIntoDB>((event, emit) async {
      emit(const LoadingState());
        await dbModule.dbInstance.visitDetailDao
            .updateVisitPunchOut(
            event.scopeId ??-1, event.endTime, event.isSync, event.userId,event.visitId?? 0)
            .then((value) async {
          await dbModule.dbInstance.cartDao.deleteAllData();
          emit(UpdateVisitPunchOutDBSuccessState(data: value));
          emit(const LoadingState(isLoading: false));
        }).catchError((e) {
          emit(const UpdateVisitPunchOutDBFailedState(msg: "update DB fail"));
          emit(const LoadingState(isLoading: false));
        });
    });

    on<GetUnSyncVisitPunchFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.visitDetailDao
          .getUnSyncPunchVisit()
          .then((value) {
        emit(GetUnSyncVisitPunchSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetUnSyncVisitPunchFailState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<VisitPunchAPICall>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .manageVisitPunchCall(ManageVisitPunchRequest(event.request))
          .then((value) {

        emit(VisitPunchAPICallSuccessState(data: value));
        print("API Call Success");
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const VisitPunchAPICallFailState(msg: "Data Not available!"));
        print("API call fail : ${e.toString()}");
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<DeleteUnSyncVisitFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.visitDetailDao.deleteUnSyncData().then((value) {
        emit(DeleteUnSyncVisitSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const DeleteUnSyncVisitFailState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
    });

    on<GetVisitDataAPICall>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getVisit(VisitRequest(
        pageIndex: event.pageIndex,
        fromTimeStamp: event.fromTimeStamp,
      ))
          .then((value) async {
        emit(GetVisitDataAPICallSuccessState(data: value));
        _saveVisitDetailIntoDatabase(value.data.items);
        print("API Call Success");
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetVisitDataAPICallFailState(msg: "Data Not available!"));
        print("API call fail : ${e.toString()}");
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetLastOrderByCustomerId>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.database.rawQuery('select * from OrderRecord where customer_id = ${event.customerId} order by created_on desc limit 1')
      // .getLastOrderByCustomerId(event.customerId)
          .then((value) {
        emit(GetLastOrderByCustomerIdSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetLastOrderByCustomerIdFailState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetLastTimeStampFromDb>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.database
          .rawQuery(
          "select max(d) from (select created_on d from VisitDetail union select modified_on d from VisitDetail)")
          .then((value) {
        String? syncDateTime;
        if (value[0]["max(d)"] != null) {
          syncDateTime = value[0]["max(d)"].toString();
        }
        // final _latestDate = LatestDate(
        //     apiSequence: event.apiSequence, latestDate: syncDateTime);
        emit(GetLastSyncDateFromDBSuccessState(data: syncDateTime));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetLastSyncDateFromDBFailState(
            msg: "There is some issue with the database table VisitDetail"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetCustomerAddressesFromDB>((event, emit) async {
      emit(const LoadingState());
      CustomerDataItemsResponse? customerData;
      await dbModule.dbInstance.customerDao.getCustomerDataBasedOnId(event.id).then((value) {
        customerData=value;
      });
      await dbModule.dbInstance.database
          .rawQuery(queryToGetTheAddressesOfCustomer(event.id))
          .then((value) {
        final customerAddress = <CustomerAddressResponse>[];
        value.forEach((v) {
          customerAddress.add(CustomerAddressResponse.fromJsonForRowQuery(v));
        });
        customerData?.customerAddress=customerAddress;
        emit(GetUpdatedCustomerDetailsSuccessState(data: customerData));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetUpdatedCustomerDetailsFailState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

  Future<void> _saveVisitDetailIntoDatabase(
      List<VisitDataItemsResponse>? userData) async =>
      await dbModule.dbInstance.visitDetailDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

  String queryToGetTheAddressesOfCustomer(int customerId) {
    return "select c.name as countryName, d.name as districtName,cd.name as stateName, l.name as locationName,ca.* "
        "from CustomerAddress as ca "
        "LEFT JOIN Country as c on c.id=ca.countryId "
        "LEFT JOIN district as d on d.Id=ca.districtId "
        "LEFT JOIN StateData as cd on ca.stateId=cd.id "
        "LEFT JOIN Location as l on ca.locationId=l.id "
        "WHERE ca.customerId=$customerId";
  }

}
