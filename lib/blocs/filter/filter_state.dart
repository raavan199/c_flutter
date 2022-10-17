part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState();
}

class FilterInitial extends FilterState {
  @override
  List<Object> get props => [];
}

class FilterGroupSuccessState extends BaseState {
  const FilterGroupSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class FilterGroupFailedState extends BaseState {
  const FilterGroupFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class FilterSubGroupSuccessState extends BaseState {
  const FilterSubGroupSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class FilterSubGroupFailedState extends BaseState {
  const FilterSubGroupFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class FilterCategorySuccessState extends BaseState {
  const FilterCategorySuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class FilterCategoryFailedState extends BaseState {
  const FilterCategoryFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}


class FilterSubCategorySuccessState extends BaseState {
  const FilterSubCategorySuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class FilterSubCategoryFailedState extends BaseState {
  const FilterSubCategoryFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}


