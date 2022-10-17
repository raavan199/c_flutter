import 'package:equatable/equatable.dart';

import '../../database/db_module.dart';
import '../../exports/resources.dart';
import '../base/base_bloc.dart';

part 'timeline_event.dart';

part 'timeline_state.dart';

class TimelineBloc extends BaseBloc<TimelineEvent> {
  TimelineBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<GetCustomerTypeListFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.customerTypeDao.getCustomerData().then((value) {
        emit(CustomerTypeSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(
            const CustomerTypeFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetVisitListFromDB>((event, emit) async {
      emit(const LoadingState());
      print("getTimeLineVisit: ${queryToGetVisitList(event.date)}");
      await dbModule.dbInstance.database
          .rawQuery(queryToGetVisitList(event.date))
          .then((value) {
        emit(VisitSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const VisitFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

  String queryToGetVisitList(String date) {
    return "SELECT * FROM ( "
        "SELECT VD.*, ORD.ID As Order_ID, ORD.total_amount, c.business_name, c.customer_type FROM VisitDetail AS VD "
        "Left JOIN VisitOrderMapping AS VOM on VOM.visit_id=vd.id "
        "Left JOIN OrderRecord  AS ORD on ORD.ID = VOM.order_id "
        "Left JOIN customer AS c ON c.id=VD.customer_id "
        "WHERE Date(VD.created_on)  = '$date' ) AS TT "
        "LEFT JOIN ( "
        "SELECT VD.ID as visit_id, n.id as no_order_id FROM VisitDetail AS VD "
        "INNER JOIN NoOrder  AS n on n.visitId =VD.ID "
        "left JOIN customer AS c ON c.id=VD.customer_id "
        "WHERE Date(VD.created_on)  = '$date' ) AS  TMP "
        "ON TMP.visit_id = TT.ID";
  }
}
