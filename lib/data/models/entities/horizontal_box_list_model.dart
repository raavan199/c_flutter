class HorizontalBoxListModel {
  HorizontalBoxListModel(
    this.count,
    this.routeName, {
    this.informationIcon,
    this.informationTitle,
    this.informationDetail,
  });

  String count;
  String routeName;
  bool? informationIcon = false;
  String? informationTitle;
  String? informationDetail;
}
