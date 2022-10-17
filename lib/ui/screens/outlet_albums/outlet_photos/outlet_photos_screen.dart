import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../blocs/base/base_bloc.dart';
import '../../../../blocs/image_file/image_file_bloc.dart';
import '../../../../exports/mixins.dart';
import '../../../../exports/models.dart';
import '../../../../exports/resources.dart';
import '../../../../exports/themes.dart';
import '../../../../exports/utilities.dart';
import '../../../../exports/widgets.dart';
import '../../../../services/api/api_service.dart';
import '../../../widgets/custom_input_field_dialog.dart';
import '../../base/base_screen.dart';

class OutletPhotosScreens extends StatefulWidget {
  OutletPhotosScreens(
      {required this.folderId,
      required this.isFromRouteInfo,
      this.outletInfo,
      Key? key})
      : super(key: key);

  int folderId;
  final CustomerDataItemsResponse? outletInfo;
  bool isFromRouteInfo;

  @override
  State<StatefulWidget> createState() => _OutletPhotosScreenState();
}

class _OutletPhotosScreenState extends State<OutletPhotosScreens>
    with UtilityMixin {
  List<File> imageList = [];
  TextEditingController _textFieldController = TextEditingController();
  late ImageFileBloc _bloc;
  List<CustomerImageItemResponse> _customerImageFile = [];
  late String caption = '';

  @override
  Widget build(BuildContext context) => BaseScreen<ImageFileBloc>(
        onBlocReady: (bloc) {
          _bloc = bloc;
          _bloc.add(GetCustomerImageFileIdFromDb(
              customerId: widget.outletInfo!.id!, folderId: widget.folderId));
        },
        builder: (context, bloc, child) =>
            BlocListener<ImageFileBloc, BaseState>(
          listener: (context, state) {
            if (state is ImageIdFromDbSuccessState) {
              _customerImageFile = state.data;
              _bloc.add(
                GetImageBasedOnFileId(
                    fileId: _customerImageFile[0].mediaFileId!, index: 0),
              );
              print('length ${_customerImageFile.length}');
            } else if (state is ImageIdFromDbFailedState) {
              print('ImageIdFromDbFailedState');
            } else if (state is GetImageFileSuccessState) {
              print('GetImageFileSuccessState');
              prepareImageFile(base64.decode(state.data),
                      _customerImageFile[state.index].mediaFileId!)
                  .then((value) {
                imageList.add(value);
                setState(() {});
                if (state.index < _customerImageFile.length - 1) {
                  _bloc.add(GetImageBasedOnFileId(
                      fileId: _customerImageFile[state.index + 1].mediaFileId!,
                      index: state.index + 1));
                }
              });
              // writeToFile(state.data);
            } else if (state is GetImageFileFailedState) {
              print('GetImageFileFailedState');
            } else if (state is UploadImageFileSuccessState) {
              imageList.clear();
              _bloc.add(GetLastTimeStampFromDb());
            } else if (state is UploadImageFileFailedState) {
              print('UploadImageFileFailedState');
            } else if (state is GetLastSyncDateFromDBSuccessState) {
              _bloc.add(CallCustomerImageApi(
                  pageIndex: 1, fromTimeStamp: state.data));
            } else if (state is GetLastSyncDateFromDBFailState) {
              print('GetLastSyncDateFromDBFailState');
            } else if (state is CustomerImageSuccessState) {
              _bloc.add(GetCustomerImageFileIdFromDb(
                  customerId: widget.outletInfo!.id!,
                  folderId: widget.folderId));
            } else if (state is CustomerImageFailState) {}
          },
          child: Scaffold(
            appBar: CustomAppBar(
              hasBack: true,
              title: 'Outlet Photos',
            ),
            body: CommonContainer(
              hasTimer: widget.isFromRouteInfo ? false : true,
              topLayout: widget.isFromRouteInfo
                  ? const CommonSimpleHeader('OutletPhotos')
                  : CommonDetailedHeader(
                      hasExtraPadding: true,
                      screenName: 'Outlet Home - 3',
                      outletName: widget.outletInfo!.businessName,
                      retailerLocation: widget.outletInfo!.routeName,
                      retailerType: widget.outletInfo!.customerTypeName,
                      date: getCurrentDate(),
                    ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Column(
                  children: [
                    if (widget.isFromRouteInfo)
                      const SizedBox(
                        height: 5,
                      )
                    else
                      NameNumberWidget(
                        retailerName:
                            widget.outletInfo!.contactPersonName ??
                                AppStrings.notAssign,
                        number: widget.outletInfo!.mobileNumber ??
                            AppStrings.notAssign,
                      ),
                    const SizedBox(
                      height: 14,
                    ),
                    SelectAlbumWidget(
                      numberOfFile : _customerImageFile.length,
                      imagePath: (value) {
                        showCaptionDialog(value, context);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (_customerImageFile.isNotEmpty &&
                        imageList.isNotEmpty)
                      Expanded(child: _imageList())
                    else if (_customerImageFile.isNotEmpty &&
                        imageList.isEmpty)
                      Center(
                          child: Text(
                        "Kindly Wait",
                        style: CustomTextStyle.titleTextStyle,
                      ))
                    else
                      Center(
                          child: Text(
                        AppStrings.msgNoDataToDisplay,
                        style: CustomTextStyle.titleTextStyle,
                      )),

                    /*  const Expanded(child: OutletAlbumGridWidget())*/
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget _imageList() => ListView.builder(
      itemCount: imageList.length,
      itemBuilder: (context, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                "${getDateAndTimeFromCreatedOn(_customerImageFile[index].created_on ?? 'N/A')} | Display Banner",
                style: CustomTextStyle.imageDetailsTextStyle,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                color: Colors.green,
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 5,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.file(imageList[index])),
                  ),
                  Positioned(
                    top: -13,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        deleteImage(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [Shadows.greyShadow],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const CircleAvatar(
                          backgroundColor: AppColors.primary,
                          radius: 13,
                          child: Icon(
                            Icons.clear,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ));

  deleteImage(int id) {

  }

  void showCaptionDialog(File value, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => CustomInputFieldDialog(
              textEditingController: _textFieldController,
              yesOnPressed: () {
                setState(() {
                  _textFieldController.clear();
                  // imageList.add(imageFile);
                });
                saveCaptureImage(value, caption);
              },
              noOnPressed: () {},
              title: "Add Caption for capture image",
              hint: "Image Caption",
              yes: AppStrings.lblAdd,
              no: AppStrings.lblCancel,
              caption: (String value) {
                if (value.isNotEmpty) {
                  caption = value;
                } else {
                  caption = getCurrentDate();
                }
              },
            ));
  }

  void saveCaptureImage(File image, String name) {
    ApiService().checkInternet().then((internet) {
      if (internet) {
        _bloc.add(UploadCustomerImageFile(
            customerId: widget.outletInfo!.id!,
            folderId: widget.folderId,
            image: image,
            isCover: false,
            caption: name));
      } else {
        showNoInternetDialog(context);
      }
    });
  }

  Future<File> writeToFile(ByteData data) async {
    final buffer = data.buffer;
    var tempDir = await getTemporaryDirectory();
    var tempPath = tempDir.path;
    var filePath =
        '$tempPath/file_01.tmp'; // file_01.tmp is dump file, can be anything
    return File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
