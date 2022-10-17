import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/models/customer/customer_address_response.dart';
import '../../../data/models/customer/customer_data_items_response.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import 'add_address_screen.dart';

class AddressListView extends StatefulWidget {
  AddressListView({
    required this.addressList,
    required this.isFromRoute,
    this.text,
    this.outletInfo,
    Key? key,
  }) : super(key: key);

  String? text;
  final CustomerDataItemsResponse? outletInfo;
  List<CustomerAddressResponse> addressList;
  bool isFromRoute;

  @override
  _AddressListViewState createState() => _AddressListViewState();
}

class _AddressListViewState extends State<AddressListView> with UtilityMixin {
  bool isDefault = true;
  int indexCount = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.addressList.length,
        itemBuilder: (context, index) => _buildItem(index),
      );

  Widget _buildItem(int index) => Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding:
                const EdgeInsets.only(top: 22, bottom: 10, left: 15, right: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [Shadows.greyShadow],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRadioWidget(
                  labelText: AppStrings.lblDefaultAddress,
                  value: widget.addressList[index].isDefaultAddress ?? false,
                  onChanged: (value) {
                    setState(() {
                      widget.addressList.forEach((element) {
                        element.isDefaultAddress = false;
                      });
                      widget.addressList[index].isDefaultAddress = value;
                    });
                  },
                  radioSelection: isDefault,
                  fontSize: 12,
                  fontWeight: AppFonts.normal,
                ),
                if (widget.text != null)
                  Text.rich(
                    TextSpan(
                        text: 'State : ',
                        style: CustomTextStyle.blackBold11,
                        children: <InlineSpan>[
                          TextSpan(
                            text: widget.addressList[index].stateName,
                            style: CustomTextStyle.blackNormal11,
                          )
                        ]),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(
                  TextSpan(
                      text: 'District : ',
                      style: CustomTextStyle.blackBold11,
                      children: <InlineSpan>[
                        TextSpan(
                          text: widget.addressList[index].districtName,
                          style: CustomTextStyle.blackNormal11,
                        )
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(
                  TextSpan(
                      text: 'Territory : ',
                      style: CustomTextStyle.blackBold11,
                      children: <InlineSpan>[
                        TextSpan(
                          text: widget.addressList[index].locationName,
                          style: CustomTextStyle.blackNormal11,
                        )
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(
                  TextSpan(
                      text: 'Address : ',
                      style: CustomTextStyle.blackBold11,
                      children: <InlineSpan>[
                        TextSpan(
                          text: widget.addressList[index].fullAddress,
                          style: CustomTextStyle.blackNormal11,
                        )
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(
                  TextSpan(
                      text: 'Pin Code : ',
                      style: CustomTextStyle.blackBold11,
                      children: <InlineSpan>[
                        TextSpan(
                          text: widget.addressList[index].pincode,
                          style: CustomTextStyle.blackNormal11,
                        )
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            )),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  color: AppColors.primary,
                  child: Text('${AppStrings.lblAddress} ${index + 1}',
                      style: CustomTextStyle.headerSubTitleTextStyle),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    _awaitReturnValueFromSecondScreen(context, index);
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 15,
                    child: SvgPicture.asset(
                      AppAssets.icEdit,
                      width: 13,
                      height: 13,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    showCustomDialog(
                        context,
                        AppStrings.msgAreYouSureAboutDeleteThisAddress,
                        AppStrings.lblDeleteAddress,
                        AppStrings.lblYes, yesOnPressed: () {
                      setState(() {
                        widget.addressList.removeAt(index);
                        print(widget.addressList);
                      });
                    }, no: AppStrings.lblNo, noOnPressed: () {});
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.statusRejected,
                    radius: 15,
                    child: SvgPicture.asset(
                      AppAssets.icDelete,
                      width: 13,
                      height: 13,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  _awaitReturnValueFromSecondScreen(BuildContext context, index) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddAddressScreen(
            outletInfo: widget.outletInfo,
            customerAddress: widget.addressList[index],
            isFromRouteInfo: widget.isFromRoute,
            editAddress: true,
          ),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    return setState(() {
      if (result != null) {
        final CustomerAddressResponse data = result;
        if (widget.addressList.isEmpty) {
          data.isDefaultAddress = true;
        }
        widget.addressList[index] = data;
        widget.outletInfo?.customerAddress = widget.addressList;
      }
    });
  }
}
