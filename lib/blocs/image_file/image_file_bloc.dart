import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cygneto/blocs/base/base_bloc.dart';
import 'package:cygneto/database/db_module.dart';
import 'package:cygneto/exports/models.dart';
import 'package:equatable/equatable.dart';

part 'image_file_event.dart';

part 'image_file_state.dart';

class ImageFileBloc extends BaseBloc<ImageFileEvent> {
  ImageFileBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<GetCustomerImageFileIdFromDb>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.customerImageDao
          .getImageIdData(
          event.customerId, event.folderId)
          .then((value) {
        emit(ImageIdFromDbSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const ImageIdFromDbFailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetImageBasedOnFileId>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getImageFile(event.fileId)
          .then((value) {
        emit(GetImageFileSuccessState(data: value.data, index: event.index));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetImageFileFailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<UploadCustomerImageFile>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .uploadCustomerImages(
          event.folderId, event.customerId, event.image, event.isCover)
      .then((value) {
      emit(UploadImageFileSuccessState(data: value));
      emit(const LoadingState(isLoading: false));
      }).catchError((e) {
      emit(const UploadImageFileFailedState(msg: "Data Not available!"));
      emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetLastTimeStampFromDb>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.database
          .rawQuery(
          "select max(d) from (select created_on d from CustomerImage union select modified_on d from CustomerImage)")
          .then((value) {
        String? syncDateTime;
        if (value[0]["max(d)"] != null) {
          syncDateTime = value[0]["max(d)"].toString();
        }
        // final _latestDate = LatestDate(
        //     apiSequence: event.apiSequence, latestDate: syncDateTime);
        emit(GetLastSyncDateFromDBSuccessState(data: syncDateTime));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetLastSyncDateFromDBFailState(
            msg: "There is some issue with the database table VisitDetail"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallCustomerImageApi event
    on<CallCustomerImageApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getCustomerImages(SchemeListRequest(
          fromTimeStamp: event.fromTimeStamp, pageIndex: event.pageIndex))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(CustomerImageSuccessState(data: value));
        _saveCustomerImageIntoDatabase(value.data!.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(CustomerImageFailState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }


  Future<void> _saveCustomerImageIntoDatabase(
      List<CustomerImageItemResponse>? userData) async =>
      await dbModule.dbInstance.customerImageDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });
}
