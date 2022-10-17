import 'package:floor/floor.dart';

import '../data/models/image_folder/image_folder_data_response.dart';

@dao
abstract class ImageFolderDao{
  @Query('Select * From ImageFolder')
  Future<List<ImageFolderDataResponse>> getAllData();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertImageFolderData(ImageFolderDataResponse imageFolderData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<ImageFolderDataResponse> imageFolderList);

  @Query("delete from ImageFolder where id = :id")
  Future<void> deleteData(int id);
}