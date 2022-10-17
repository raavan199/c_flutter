///filter item
class FilterItemModel {
  FilterItemModel(
    this.name, {
    this.isSelected = false,
    this.subItems,
    this.id,
  });

  final int? id;
  final String? name;
  final List<FilterItemModel>? subItems;
  bool isSelected;
}
