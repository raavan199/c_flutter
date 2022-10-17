import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';

class OutletAlbumGridWidget extends StatelessWidget {
  OutletAlbumGridWidget({
    required this.onTapItem,
    required this.imageFolderList,
    Key? key,
  }) : super(key: key);

  final Function  onTapItem;
  List<ImageFolderDataResponse> imageFolderList;

  @override
  Widget build(BuildContext context) => GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 25,
        children: List.generate(
            imageFolderList.length,
            (index) => InkWell(
              onTap: () =>  onTapItem(imageFolderList[index].id),
              child: Center(
                    child: _GridCard(imageFolderList[index].name),
                  ),
            )),
      );
}

Widget _GridCard(String name) => Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Card(
            color: AppColors.border,
              shadowColor: AppColors.border.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppColors.border, width: 0),
                  borderRadius: BorderRadius.circular(5)),
              elevation: 2,
              child: Image.asset(AppAssets.imgPlaceHolder),
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.bottomCenter,
            child: Text(name, style: CustomTextStyle.mobileNumberTextStyle))
      ],
    );
