class SKUModel {
  SKUModel({
    required this.type,
    required this.subType,
  });

  String type;
  String subType;
}

class UOMModel {
  UOMModel({
    required this.id,
    required this.name,
  });

  int id;
  String name;
}
