import 'package:equatable/equatable.dart';

import '../../database/db_module.dart';
import '../base/base_bloc.dart';

part 'image_folder_event.dart';

part 'image_folder_state.dart';

class ImageFolderBloc extends BaseBloc<ImageFolderEvent> {
  ImageFolderBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<GetImageFolderListFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.imageFolderDao.getAllData().then((value) {
        emit(ImageFolderSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const ImageFolderFailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }
}
