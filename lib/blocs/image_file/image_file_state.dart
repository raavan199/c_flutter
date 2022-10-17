part of 'image_file_bloc.dart';

abstract class ImageFileState extends Equatable {
  const ImageFileState();

  @override
  List<Object?> get props => [];
}

class ImageIdFromDbSuccessState extends BaseState {
  const ImageIdFromDbSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class ImageIdFromDbFailedState extends BaseState {
  const ImageIdFromDbFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetImageFileSuccessState extends BaseState {
  const GetImageFileSuccessState({this.data,required this.index});

  final dynamic data;
  final int index;

  @override
  List<Object> get props => <Object>[data,index];
}

class GetImageFileFailedState extends BaseState {
  const GetImageFileFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}


class UploadImageFileSuccessState extends BaseState {
  const UploadImageFileSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class UploadImageFileFailedState extends BaseState {
  const UploadImageFileFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
class GetLastSyncDateFromDBSuccessState extends BaseState {
  const GetLastSyncDateFromDBSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetLastSyncDateFromDBFailState extends BaseState {
  const GetLastSyncDateFromDBFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class CustomerImageSuccessState extends BaseState {
  const CustomerImageSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class CustomerImageFailState extends BaseState {
  const CustomerImageFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
