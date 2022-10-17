part of 'filter_bloc.dart';

@immutable
abstract class FilterEvent extends Equatable{
  const FilterEvent();

  @override
  List<Object?> get props => [];
}

class GetGroupListFromDB extends FilterEvent{
  @override
  List<Object> get props => [];
}

class GetSubGroupListFromDB extends FilterEvent{
  GetSubGroupListFromDB({required this.id});
  int id;

  @override
  List<Object> get props => [id];
}

class GetCategoryListFromDB extends FilterEvent{

  @override
  List<Object> get props => [];
}

class GetSubCategoryListFromDB extends FilterEvent{
  GetSubCategoryListFromDB({required this.id});
  int id;


  @override
  List<Object> get props => [];
}


