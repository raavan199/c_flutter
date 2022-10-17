part of 'image_folder_bloc.dart';

abstract class ImageFolderState extends Equatable {
  const ImageFolderState();

  @override
  List<Object?> get props => [];
}

//Image Folder State
class ImageFolderSuccessState extends BaseState {
  const ImageFolderSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class ImageFolderFailedState extends BaseState {
  const ImageFolderFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

