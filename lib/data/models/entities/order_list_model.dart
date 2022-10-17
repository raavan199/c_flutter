class OrderListModel {
  OrderListModel({
    this.id,
    required this.name,
    required this.qty,
    required this.price,
    required this.gst,
    required this.scheme,
    required this.amount,
    required this.payable,
  });

  int? id;
  String name;
  String qty;
  String price;
  String gst;
  String scheme;
  String amount;
  String payable;

}
