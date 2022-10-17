class ProductDataModel {
  ProductDataModel({
    required this.image,
    required this.name,
    required this.variant,
    required this.stock,
    required this.price,
    required this.mrp,
    this.isSelected = false,
  });

  String image;
  String name;
  String variant;
  String stock;
  String price;
  String mrp;
  bool isSelected;
}
