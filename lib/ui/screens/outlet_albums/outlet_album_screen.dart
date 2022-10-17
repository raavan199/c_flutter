import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/image_folder/image_folder_bloc.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../base/base_screen.dart';
import 'outlet_album_grid_widgets.dart';
import 'outlet_photos/outlet_photos_screen.dart';

class OutletAlbumScreen extends StatefulWidget {
  OutletAlbumScreen({required this.isFromRouteInfo, this.outletInfo, Key? key})
      : super(key: key);

  final CustomerDataItemsResponse? outletInfo;
  bool isFromRouteInfo;

  @override
  State<StatefulWidget> createState() => _OutletAlbumScreenState();
}

class _OutletAlbumScreenState extends State<OutletAlbumScreen>
    with UtilityMixin {
  List<ImageFolderDataResponse> _imageFolderList = [];
  late ImageFolderBloc _bloc;
  int selectedFolder = -1;

  @override
  Widget build(BuildContext context) => BaseScreen<ImageFolderBloc>(
        onBlocReady: (bloc) {
          _bloc = bloc;
          _bloc.add(GetImageFolderListFromDB());
        },
        builder: (context, bloc, child) =>
            BlocListener<ImageFolderBloc, BaseState>(
          listener: (context, state) {
            if (state is ImageFolderSuccessState) {
              _imageFolderList = state.data;
            } else if (state is ImageFolderFailedState) {
            }
          },
          child: Scaffold(
            appBar: CustomAppBar(
              title: 'Outlet Photos',
              hasBack: true,
            ),
            body: CommonContainer(
              hasTimer: widget.isFromRouteInfo ? false : true,
              topLayout: widget.isFromRouteInfo
                  ? CommonSimpleHeader('OutletPhotos')
                  : CommonDetailedHeader(
                      hasExtraPadding: true,
                      screenName: 'Outlet Home - 3',
                      outletName: widget.outletInfo!.businessName,
                      retailerLocation: widget.outletInfo!.routeName,
                      retailerType: widget.outletInfo!.customerTypeName,
                      date: getCurrentDate(),
                    ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 35, 15, 0),
                child: Column(
                  children: [
                    if (widget.isFromRouteInfo)
                      const SizedBox(
                        height: 5,
                      )
                    else
                      NameNumberWidget(
                        retailerName: widget.outletInfo!.contactPersonName ??
                            AppStrings.notAssign,
                        number: widget.outletInfo!.mobileNumber ??
                            AppStrings.notAssign,
                      ),
                    const SizedBox(
                      height: 15,
                    ),
                    /*const SelectAlbumWidget(),
                const SizedBox(height: 15,),*/
                    Expanded(
                      child: OutletAlbumGridWidget(
                        imageFolderList: _imageFolderList,
                        onTapItem: _albumSelected,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

   _albumSelected(int id) async {
    await navigationWithAwaitPush(
        context,
        OutletPhotosScreens(
          folderId: id,
          isFromRouteInfo: widget.isFromRouteInfo,
          outletInfo: widget.outletInfo,
        ));
    setState(() {

    });
  }
}
