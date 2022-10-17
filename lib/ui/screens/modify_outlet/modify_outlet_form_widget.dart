import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/models/route/get_route_by_user_items.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../../widgets/custom_dropdown_modify_category.dart';
import '../../widgets/custom_dropdown_modify_outlets.dart';
import '../../widgets/custom_dropdown_route_outlet.dart';
import '../../widgets/custom_dropdown_select_supplier.dart';
import '../../widgets/custom_number_input.dart';
import 'add_address_screen.dart';
import 'modify_outlet_address_list_view.dart';

class ModifyOutletFormWidget extends StatefulWidget {
  ModifyOutletFormWidget(
      {required this.isFromRoute,
      required this.customerType,
      required this.formKey,
      this.customerData,
      this.customerCategoryList,
      this.supplierList,
      this.routeList,
      this.selectedSupplierList,
      Key? key})
      : super(key: key);

  bool isFromRoute;
  List<CustomerTypeDataResponse> customerType = [];
  CustomerDataItemsResponse? customerData;
  List<CustomerCategoryDataResponse>? customerCategoryList;
  List<DistributionData>? supplierList;
  List<RouteItems>? routeList;
  GlobalKey<FormState> formKey;
  List<DistributionData>? selectedSupplierList = [];

  @override
  State<StatefulWidget> createState() => _ModifyOutletFormWidgetState();
}

class _ModifyOutletFormWidgetState extends State<ModifyOutletFormWidget>
    with ValidationMixin, UtilityMixin {
  late String text = '';
  List<CustomerAddressResponse> _addressList = [];
  TextEditingController custBusinessName = TextEditingController();
  TextEditingController custContactName = TextEditingController();
  TextEditingController custMobileNo = TextEditingController();
  TextEditingController custEmail = TextEditingController();
  TextEditingController custGSTINNo = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (!widget.isFromRoute) {
      print("customer id:${widget.customerData?.id}");
      custBusinessName.text = widget.customerData?.businessName ?? "";
      custContactName.text = widget.customerData?.contactPersonName ?? "";
      custMobileNo.text = widget.customerData?.mobileNumber ?? "";
      custEmail.text = widget.customerData?.emailAddress ?? "";
      custGSTINNo.text = widget.customerData?.gstin?.toUpperCase() ?? "";
      _addressList = widget.customerData?.customerAddress ?? [];
    } else {
      widget.customerData = CustomerDataItemsResponse();
    }
  }

  @override
  void didUpdateWidget(covariant ModifyOutletFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("customerType  list:${widget.customerType.length}");
    widget.customerType.forEach((element) {
      if (element.id == widget.customerData?.customerType) {
        print("match done ");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _modifyOutletBody();
  }

  Widget _modifyOutletBody() => Form(
        key: widget.formKey,
        child: Column(
          children: [
            CustomTextInputField(
              labelText: AppStrings.lblCustomerBusinessName,
              controller: custBusinessName,
              onChanged: (value) {
                widget.customerData?.businessName = value;
              },
              validator: (value) => requiredFieldValidation(value!) != ""
                  ? requiredFieldValidation(value)
                  : null,
            ),
            const SizedBox(
              height: 17,
            ),
            CustomTextInputField(
              labelText: AppStrings.lblCustomerContactPersonName,
              controller: custContactName,
              onChanged: (value) {
                widget.customerData?.contactPersonName = value;
              },
              validator: (value) => requiredFieldValidation(value!) != ""
                  ? requiredFieldValidation(value)
                  : null,
            ),
            const SizedBox(
              height: 17,
            ),
            CustomNumberInputField(
              maxLength: 10,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              inputType: TextInputType.phone,
              labelText: AppStrings.lblMobileNumber,
              onChanged: (value) {
                widget.customerData?.mobileNumber = value;
              },
              controller: custMobileNo,
              validator: (value) => phoneFieldValidation(value!) != ""
                  ? phoneFieldValidation(value)
                  : null,
            ),
            const SizedBox(
              height: 17,
            ),
            CustomTextInputField(
              inputType: TextInputType.emailAddress,
              labelText: AppStrings.lblEmail,
              onChanged: (value) {
                widget.customerData?.emailAddress = value;
              },
              controller: custEmail,
              validator: (value) => validateEmailAllowBlank(value!),
            ),
            const SizedBox(
              height: 17,
            ),
            CustomDropDownModifyOutlets(
              labelText: AppStrings.lblOutletType,
              items: widget.customerType,
              initialValue: widget.customerData?.customerType,
              iconPath: AppAssets.icDropDownArrow,
              customerDataItemsResponse: widget.customerData,
              validator: (value) {
                if (value == null) {
                  return AppStrings.emptyValidation;
                }
              },
              customerType: (value) {
                final CustomerTypeDataResponse data = value;
                widget.customerData?.customerType = data.id;
                widget.customerData?.customerTypeName = data.typeName;
              },
            ),
            const SizedBox(
              height: 17,
            ),
            CustomDropdownCategoryModifyOutlets(
              labelText: AppStrings.lblOutletCategory,
              items: widget.customerCategoryList,
              initialValue: widget.customerData?.customerCategory,
              iconPath: AppAssets.icDropDownArrow,
              customerDataItemsResponse: widget.customerData,
              validator: (value) {
                if (value == null) {
                  return AppStrings.emptyValidation;
                }
              },
              category: (value) {
                final data = value;
                widget.customerData?.customerCategory = data.id;
                widget.customerData?.customerCategoryName = data.categoryName;
              },
            ),
            const SizedBox(
              height: 17,
            ),
            CustomTextInputField(
              maxLength: 15,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              isUpperCase: true,
              labelText: AppStrings.lblGSTIN,
              controller: custGSTINNo,
              onChanged: (value) {
                widget.customerData?.gstin = value.toUpperCase();
              },
              validator: (value) => gstFieldValidation(value!) != ""
                  ? gstFieldValidation(value)
                  : null,
            ),
            const SizedBox(
              height: 17,
            ),
            CustomDropdownRouteOutlets(
              labelText: AppStrings.lblRoute,
              items: widget.routeList,
              initialValue: widget.customerData?.routeId,
              iconPath: AppAssets.icDropDownArrow,
              customerDataItemsResponse: widget.customerData,
              validator: (value) {
                if (value == null) {
                  return AppStrings.emptyValidation;
                }
              },
              route: (value) {
                final data = value;
                widget.customerData?.routeId = data.id;
                widget.customerData?.routeName = data.name;
              },
            ),
            const SizedBox(
              height: 17,
            ),
            CustomDropdownSelectSupplier(
              labelText: AppStrings.lblSelectDistributor,
              items: widget.supplierList,
              iconPath: AppAssets.icDropDownArrow,
              validator: (value) {
                if (widget.selectedSupplierList!.isEmpty) {
                  return AppStrings.emptyValidation;
                }
              },
              selectedSupplier: (value) {
                final DistributionData data = value;
                if (widget.selectedSupplierList!.isEmpty) {
                  setState(() {
                    widget.selectedSupplierList?.add(value);
                  });
                } else if (widget.selectedSupplierList!.length < 3) {
                  int? supplierId;
                  for (final element in widget.selectedSupplierList!) {
                    if (element.id == data.id) {
                      supplierId = element.id;
                      break;
                    }
                  }
                  if (supplierId != data.id) {
                    setState(() {
                      widget.selectedSupplierList?.add(data);
                    });
                  } else {
                    showCustomFlushBar(
                        context, AppStrings.msgThisSupplierIsAlreadyAdded);
                  }
                } else {
                  showCustomFlushBar(
                      context, AppStrings.msgCantAddMoreThanThreeSupplier);
                }
              },
            ),
            const SizedBox(
              height: 17,
            ),
            if (widget.selectedSupplierList!.isNotEmpty) gridSupplierListView(),
            const SizedBox(
              height: 17,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [Shadows.greyShadow],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.lblAddress,
                    style: CustomTextStyle.smallTextStyle,
                  ),
                  InkWell(
                    onTap: () {
                      _awaitReturnValueFromSecondScreen(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: 13,
                      child: SvgPicture.asset(
                        AppAssets.icAdd,
                        width: 12,
                        height: 12,
                        color: AppColors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            // if(widget.isFromRoute == false)
            if (_addressList.isNotEmpty)
              AddressListView(
                text: text,
                addressList: _addressList,
                outletInfo: widget.customerData,
                isFromRoute: widget.isFromRoute,
              ),
            const SizedBox(
              height: 17,
            ),
          ],
        ),
      );

  Widget gridSupplierListView() => Column(
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [Shadows.greyShadow],
                borderRadius: BorderRadius.circular(5),
              ),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: widget.selectedSupplierList?.length,
                itemBuilder: (context, index) => Stack(children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 8, 25, 8),
                      child: Center(
                        child: Text(
                          widget.selectedSupplierList?[index].businessName ??
                              '',
                          style: CustomTextStyle.headerSubTitleTextStyle,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.selectedSupplierList!.removeAt(index);
                          print('abcd ${widget.selectedSupplierList?.length}');
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.clear,
                          size: 20,
                          color: AppColors.red,
                        ),
                      ),
                    ),
                  )
                ]),
              )),
          const SizedBox(
            height: 17,
          ),
        ],
      );

  Future<void> _awaitReturnValueFromSecondScreen(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddAddressScreen(
            outletInfo: widget.customerData,
            isFromRouteInfo: widget.isFromRoute,
            customerAddress: CustomerAddressResponse(),
            editAddress: false,
          ),
        ));
    // after the SecondScreen result comes back update the Text widget with it
    return setState(() {
      if (result != null) {
        final CustomerAddressResponse data = result;
        if (_addressList.isEmpty) {
          data.isDefaultAddress = true;
        }
        _addressList.add(data);
        widget.customerData?.customerAddress = _addressList;
        print(widget.customerData?.customerAddress?.length);
      }
    });
  }
}
