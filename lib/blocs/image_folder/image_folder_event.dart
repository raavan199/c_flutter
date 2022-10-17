part of 'image_folder_bloc.dart';

abstract class ImageFolderEvent extends Equatable {
  const ImageFolderEvent();

  @override
  List<Object?> get props => [];
}

class GetImageFolderListFromDB extends ImageFolderEvent {
  const GetImageFolderListFromDB();
   @override
  List<Object> get props => [];
}

