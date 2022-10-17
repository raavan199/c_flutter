import 'package:equatable/equatable.dart';

import '../../database/db_module.dart';
import '../../resources/app_strings.dart';
import '../base/base_bloc.dart';

part 'analysis_event.dart';

part 'analysis_state.dart';

class AnalysisBloc extends BaseBloc<AnalysisEvent> {
  AnalysisBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<GetCurrentFyDataFromDatabaseEvent>((event, emit) async {
      emit(const LoadingState());
      print(queryToGetCurrentFyData(event.customerId));
      await dbModule.dbInstance.database
          .rawQuery(queryToGetCurrentFyData(event.customerId))
          .then((value) {
        emit(CurrentFyDataSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const CurrentFyDataFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetCurrentJcData>((event, emit) async {
      emit(const LoadingState());
      print(queryToGetCurrentJcData(event.customerId, event.currentDate));
      await dbModule.dbInstance.database
          .rawQuery(
              queryToGetCurrentJcData(event.customerId, event.currentDate))
          .then((value) {
        emit(CurrentJcDataSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const CurrentJcDataFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetPrevFyData>((event, emit) async {
      emit(const LoadingState());
      print(queryToGetPrevFyData(event.customerId, event.currentDate));
      await dbModule.dbInstance.database
          .rawQuery(queryToGetPrevFyData(event.customerId, event.currentDate))
          .then((value) {
        emit(PrevFyDataSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const PrevFyDataFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetPrevJcData>((event, emit) async {
      emit(const LoadingState());
      print(queryToGetPrevJcData(event.customerId, event.currentDate));
      await dbModule.dbInstance.database
          .rawQuery(queryToGetPrevJcData(event.customerId, event.currentDate))
          .then((value) {
        emit(PrevJcDataSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const PrevJcDataFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

  String queryToGetCurrentFyData(int customerId) {
    return "select ii.*, vd.partner_id from InvoiceItem as ii "
        "inner join orderinvoicemapping as oim on oim.id=ii.secondaryInvoiceId "
        "inner join financialyear as fy on fy.id=oim.fyId "
        "left join visitordermapping vom on vom.order_id=oim.orderId "
        "left join visitdetail as vd on vd.id=vom.visit_id "
        "and vd.customer_id=oim.customerId "
        "where oim.customerId=$customerId and fy.isCurrentYear=1 order by ii.created_on";
  }

  String queryToGetCurrentJcData(int customerId, String currentDate) {
    return "select ii.*, vd.partner_id from InvoiceItem as ii "
        "inner join orderinvoicemapping as oim on oim.id=ii.secondaryInvoiceId "
        "inner join journeycycle as jc on jc.id=oim.jcId "
        "left join visitordermapping vom on vom.order_id=oim.orderId "
        "left join visitdetail as vd on vd.id=vom.visit_id "
        "and vd.customer_id=oim.customerId "
        "where oim.customerId=$customerId and '$currentDate' between date(jc.startDate) and date(jc.endDate) order by ii.created_on ";
  }

  String queryToGetPrevFyData(int customerId, String currentDate) {
    return "select ii.*, vd.partner_id from InvoiceItem as ii "
        "inner join orderinvoicemapping as oim on oim.id=ii.secondaryInvoiceId "
        "inner join journeycycle as jc on jc.id=oim.jcId "
        "left join visitordermapping vom on vom.order_id=oim.orderId "
        "left join visitdetail as vd on vd.id=vom.visit_id "
        "and vd.customer_id=oim.customerId "
        "where oim.customerId=$customerId and '$currentDate' between date(jc.startDate) and date(jc.endDate) order by ii.created_on ";
  }

  String queryToGetPrevJcData(int customerId, String currentDate) {
    return "With FinancialDate AS(Select  DATE(startDate,'-1 day') AS PStartDate From FinancialYear "
        "Where '$currentDate' BETWEEN Date(startDate) and DATE(endDate)) "
        "select ii.*, vd.partner_id from InvoiceItem as ii "
        "inner join orderinvoicemapping as oim on oim.id=ii.secondaryInvoiceId "
        "inner join FinancialYear as fy on fy.id=oim.fyId "
        "inner Join FinancialDate AS fd on fd.PStartDate Between date(fy.startDate) and date(fy.endDate) "
        "left join visitordermapping vom on vom.order_id=oim.orderId "
        "left join visitdetail as vd on vd.id=vom.visit_id and vd.customer_id=oim.customerId "
        "where oim.customerId=$customerId order by ii.created_on";
  }
}
