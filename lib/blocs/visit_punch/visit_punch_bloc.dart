import 'package:cygneto/resources/app_strings.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/visit/manage_visit_punch_request.dart';
import '../../data/models/visit/visit_data_items_response.dart';
import '../../data/models/visit/visit_request.dart';
import '../../database/db_module.dart';
import '../../exports/constants.dart';
import '../base/base_bloc.dart';
import '../sync/sync_bloc.dart';

part 'visit_punch_event.dart';

part 'visit_punch_state.dart';

class VisitPunchBloc extends BaseBloc<VisitPunchEvent> {
  VisitPunchBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<GetVisitPartnerListFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.visitPartnerDao.getAllData().then((value) {
        emit(VisitPartnersSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const VisitPartnersFailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetCustomerDetailFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.customerDao
          .getCustomerDataBasedOnId(event.id)
          .then((value) {
        emit(CustomerSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const CustomerFailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetLastVisitByCustomerIdFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.visitDetailDao
          .getVisitBasedOnCustomerId(event.id)
          .then((value) {
        emit(GetLastVisitByCustomerIdSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetLastVisitByCustomerIdFailedState(
            msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<InsertVisitDetailIntoDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.visitDetailDao
          .insertVisitDetailData(VisitDataItemsResponse(
              visitType: event.visitType,
              makeOwner: event.makeOwner,
              customerId: event.customerId,
              startTime: event.startTime,
              endTime: event.endTime,
              scopeId: event.scopeId,
              id: event.scopeId,
              createdBy: event.userId,
              createdOn: event.startTime,
              isSync: SyncStatus.unSync))
          .then((value) {
        emit(const VisitPunchInDBSuccessState(data: ''));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const VisitFailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
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

    on<GetVisitDataAPICall>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getVisit(VisitRequest(
        pageIndex: event.pageIndex,
        fromTimeStamp: event.fromTimeStamp,
      ))
          .then((value) {
        _saveVisitDetailIntoDatabase(value.data.items);
        emit(GetVisitDataAPICallSuccessState(data: value));
        print("API Call Success");
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetVisitDataAPICallFailState(msg: "Data Not available!"));
        print("API call fail : ${e.toString()}");
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetPunchVisitByCustomerIdFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.visitDetailDao
          .getVisitBasedOnCustomerId(event.id)
          .then((value) {
        emit(GetPunchVisitByCustomerIdSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetPunchVisitByCustomerIdFailedState(
            msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetCustomerAddressesFromDB>((event, emit) async {
      emit(const LoadingState());
      print(queryToGetTheAddressesOfCustomer(event.id));
      await dbModule.dbInstance.database
          .rawQuery(queryToGetTheAddressesOfCustomer(event.id))
          .then((value) {
        emit(CustomerAddressSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const CustomerAddressFailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetOrderDataFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.database
          .rawQuery(queryToGetOrderData(event.orderId))
          .then((value) {
        emit(OrderDataSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const OrderDataFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetNoOrderDataFromDB>((event, emit) async {
      emit(const LoadingState());
      print(queryToGetNoOrderData(event.noOrderId));
      await dbModule.dbInstance.database
          .rawQuery(queryToGetNoOrderData(event.noOrderId))
          .then((value) {
        emit(NoOrderDataSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const NoOrderDataFailedState(msg: AppStrings.msgDataNotAvailable));
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

  String queryToGetOrderData(int orderId) {
    return "Select oi.*, pl.name as name,um.uom_name as selected_uom, sc.name as scheme_name From OrderItem as oi "
        "Inner Join productList  as pl on pl.id =oi.product_id "
        "Inner Join UnitOfMeasure as um on um.id =oi.uom "
        "Left  Join Scheme  as sc on sc.id =oi.scheme_id "
        "Where oi.order_id=$orderId";
  }

  String queryToGetNoOrderData(int noOrderId) {
    return "select nt.type_name from noordertype as nt "
    "inner join noorder as nor on nor.no_order_type_id=nt.id "
    "where nor.id=$noOrderId";
  }
}
