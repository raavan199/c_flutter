import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../database/db_module.dart';
import '../../services/api/api_service.dart';
import '../../services/service_locator.dart';

part 'base_event.dart';
part 'base_state.dart';

/// Created by Dev 2301 on 10/28/2021
/// Modified by Dev 2301 on 10/28/2021
/// Purpose : base bloc class extended by all blocs
class BaseBloc<T> extends Bloc<T, BaseState> {
  BaseBloc() : super(InitialState()) {
    on<T>((event, emit) {});
  }
  final apiService = locator<ApiService>();
  late DBModule dbModule;
}
