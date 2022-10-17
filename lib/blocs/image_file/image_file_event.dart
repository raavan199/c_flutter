part of 'image_file_bloc.dart';

abstract class ImageFileEvent extends Equatable {
  const ImageFileEvent();

  @override
  List<Object?> get props => [];
}

class GetImageBasedOnFileId extends ImageFileEvent {
  const GetImageBasedOnFileId({
    required this.fileId,
    required this.index,
  });

  final int fileId;
  final int index;

  @override
  List<Object> get props => [fileId,index];
}

class GetCustomerImageFileIdFromDb extends ImageFileEvent {
  const GetCustomerImageFileIdFromDb(
      {required this.customerId, required this.folderId});

  final int customerId;
  final int folderId;

  @override
  List<Object> get props => [customerId, folderId];

  @override
  String toString() =>
      'GetCustomerImageFileIdFromDb { customerId: $customerId, folderId: $folderId,}';
}

class UploadCustomerImageFile extends ImageFileEvent {
  const UploadCustomerImageFile(
      {required this.customerId,
      required this.folderId,
      required this.image,
      required this.isCover,
      required this.caption});

  final int customerId;
  final int folderId;
  final File image;
  final bool isCover;
  final String caption;

  @override
  List<Object> get props => [customerId, folderId, image, isCover,caption];

  @override
  String toString() =>
      'UploadCustomerImageFile { customerId: $customerId, '
          'folderId: $folderId, image: $image, isCover: $isCover, caption: $caption,}';
}

///event to get the lastSync Time of the perticular table
class GetLastTimeStampFromDb extends ImageFileEvent {
  const GetLastTimeStampFromDb();

  @override
  List<Object> get props => [];
}

class CallCustomerImageApi extends ImageFileEvent {
  const CallCustomerImageApi({
    required this.pageIndex,
    required this.fromTimeStamp,
  });

  final int pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex, fromTimeStamp!];

  @override
  String toString() => 'CallCustomerApi { pageIndex: $pageIndex, fromTimeStamp: $fromTimeStamp, }';
}
