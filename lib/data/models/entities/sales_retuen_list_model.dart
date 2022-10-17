import '../../../exports/constants.dart';

/// Created by Dev 2183 on 12/14/2021
/// Modified by Dev 2183 on 12/14/2021
/// Purpose : Sales Return History list item model

class SalesReturnListModel {
  SalesReturnListModel({
    required this.name,
    required this.entryDate,
    required this.qty,
    required this.status,
    required this.price,
  });

  String name;
  String entryDate;
  String qty;
  RequestStatus status;
  String price;

}
