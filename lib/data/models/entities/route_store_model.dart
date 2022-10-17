class RouteStoreModel {
  RouteStoreModel({
    required this.name,
    required this.initials,
    this.contactPersonName,
    this.number,
    this.isPositive = false,
  });

  String name;
  String initials;
  String? contactPersonName;
  String? number;
  bool isPositive;
}
