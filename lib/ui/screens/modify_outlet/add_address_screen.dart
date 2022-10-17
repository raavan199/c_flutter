import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../../../blocs/address/address_bloc.dart';
import '../../../blocs/base/base_bloc.dart';
import '../../../constants/app_constants.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../../../mixins/validation_mixin.dart';
import '../../../services/shared_preference_service.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/custom_dropdown_disctict_address.dart';
import '../../widgets/custom_dropdown_state.dart';
import '../../widgets/custom_dropdown_territory_address.dart';
import '../../widgets/custom_number_input.dart';
import '../base/base_screen.dart';

class AddAddressScreen extends StatefulWidget {
  AddAddressScreen({
    required this.isFromRouteInfo,
    required this.editAddress,
    this.customerAddress,
    this.outletInfo,
    Key? key,
  }) : super(key: key);

  CustomerAddressResponse? customerAddress;
  final CustomerDataItemsResponse? outletInfo;
  bool isFromRouteInfo;
  bool editAddress;

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen>
    with ValidationMixin, UtilityMixin, PermissionService {
  TextEditingController _addressTec = TextEditingController();
  TextEditingController _pincodeTec = TextEditingController();
  TextEditingController _latLongTec = TextEditingController();
  List<StateDataItemResponse> _stateList = [];
  List<DistrictItems> _districtList = [];
  List<LocationDataItems> _territoryList = [];
  LocationDataItems? _territoryItem;
  late AddressBloc _bloc;
  DateTime now = DateTime.now();
  DistrictItems? distrcitItem;
  CustomerAddressResponse? addressObject;
  List<CountryData> _countryList = [];
  final _formKey = GlobalKey<FormState>();
  final _dropdownStateKey = GlobalKey<FormFieldState>();
  final _dropdownDistrictKey = GlobalKey<FormFieldState>();
  final _dropdownTerritoryKey = GlobalKey<FormFieldState>();
  Position? _currentPosition;
  bool valueChange = false;

  @override
  void initState() {
    super.initState();
    if (widget.editAddress) {
      if (widget.customerAddress != null) {
        addressObject = CustomerAddressResponse(
          id: widget.customerAddress?.id,
          customerId: widget.customerAddress?.customerId,
          pincode: widget.customerAddress?.pincode,
          contactPersonName: widget.customerAddress?.contactPersonName,
          countryId: widget.customerAddress?.countryId,
          countryName: widget.customerAddress?.countryName,
          stateId: widget.customerAddress?.stateId,
          stateName: widget.customerAddress?.stateName,
          districtId: widget.customerAddress?.districtId,
          districtName: widget.customerAddress?.districtName,
          locationId: widget.customerAddress?.locationId,
          locationName: widget.customerAddress?.locationName,
          fullAddress: widget.customerAddress?.fullAddress,
          isDefaultAddress: widget.customerAddress?.isDefaultAddress,
          latitude: widget.customerAddress?.latitude,
          isActive: widget.customerAddress?.isActive,
          longitude: widget.customerAddress?.longitude,
          createdBy: widget.customerAddress?.createdBy,
          createdOn: widget.customerAddress?.createdOn,
          modifiedBy: widget.customerAddress?.modifiedBy,
          modifiedOn: widget.customerAddress?.modifiedOn,
        );
        _addressTec.text = widget.customerAddress?.fullAddress ?? "";
        _pincodeTec.text = widget.customerAddress?.pincode ?? "";
        _latLongTec.text =
            'Lat - ${widget.customerAddress?.latitude} , Long - ${widget.customerAddress?.longitude}';
      }
    } else {
      addressObject = CustomerAddressResponse();
    }
  }

  @override
  Widget build(BuildContext context) => BaseScreen<AddressBloc>(
        onBlocReady: (bloc) {
          _bloc = bloc;
          _bloc.add(GetStatesBaseOnCountryEvent(id: 1));
        },
        builder: (context, bloc, child) => BlocListener<AddressBloc, BaseState>(
          listener: (context, state) {
            if (state is StateInAddressSuccessState ||
                state is StateInAddressFailedState) {
              _manageStateStates(state);
            } else if (state is DistrictInAddressSuccessState ||
                state is DistrictInAddressFailedState) {
              _manageDistrictStates(state);
            } else if (state is LocationInAddressSuccessState ||
                state is LocationInAddressFailedState) {
              _manageTerritoryStates(state);
            }
          },
          child: Scaffold(
            appBar: CustomAppBar(
              hasBack: true,
              title: AppStrings.lblAddAddress.toUpperCase(),
            ),
            body: SafeArea(
              child: CommonContainer(
                hasTimer: !widget.isFromRouteInfo,
                topLayout: !widget.isFromRouteInfo ? CommonDetailedHeader(
                  hasExtraPadding: true,
                  screenName: '',
                  outletName: widget.isFromRouteInfo
                      ? ""
                      : widget.outletInfo?.businessName,
                  retailerLocation:
                      widget.isFromRouteInfo ? "" : widget.outletInfo?.routeName,
                  retailerType: widget.isFromRouteInfo
                      ? ""
                      : widget.outletInfo?.customerTypeName,
                  date: DateFormat('dd/MM/yyyy').format(now),
                  showActions: true,
                ):const SizedBox(
                  height: 10,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, bottom: 15, left: 15, right: 15),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    CustomDropdownStateAddress(
                                      key: _dropdownStateKey,
                                      labelText: AppStrings.lblState,
                                      initialValue: !valueChange
                                          ? addressObject?.stateId
                                          : null,
                                      items: _stateList,
                                      iconPath: AppAssets.icDropDownArrow,
                                      validator: (value) {
                                        if (value == null) {
                                          return AppStrings.emptyValidation;
                                        }
                                      },
                                      state: (value) {
                                        valueChange = true;
                                        final StateDataItemResponse _stateItem =
                                            value;
                                        addressObject?.stateId = _stateItem.id;
                                        addressObject?.stateName =
                                            _stateItem.name;
                                        _bloc.add(GetDistrictsBaseOnStateEvent(
                                            id: _stateItem.id!));
                                      },
                                    ),
                                    const SizedBox(
                                      height: 17,
                                    ),
                                    CustomDropdownDistrictAddress(
                                      key: _dropdownDistrictKey,
                                      labelText: AppStrings.lblDistrict,
                                      items: _districtList,
                                      iconPath: AppAssets.icDropDownArrow,
                                      initialValue: !valueChange
                                          ? addressObject?.districtId
                                          : null,
                                      validator: (value) {
                                        if (value == null) {
                                          return AppStrings.emptyValidation;
                                        }
                                      },
                                      district: (value) {
                                        valueChange = true;
                                        distrcitItem = value;
                                        addressObject?.districtId =
                                            distrcitItem?.id;
                                        addressObject?.districtName =
                                            distrcitItem?.name;
                                        _bloc.add(GetLocationBasedOnDistrictEvent(
                                            id: distrcitItem!.id!));
                                      },
                                    ),
                                    const SizedBox(
                                      height: 17,
                                    ),
                                    CustomDropdownTerritoryAddress(
                                      key: _dropdownTerritoryKey,
                                      labelText: AppStrings.lblLocation,
                                      items: _territoryList,
                                      initialValue: !valueChange
                                          ? addressObject?.locationId
                                          : null,
                                      iconPath: AppAssets.icDropDownArrow,
                                      validator: (value) {
                                        if (value == null) {
                                          return AppStrings.emptyValidation;
                                        }
                                      },
                                      territory: (value) {
                                        _territoryItem = value;
                                        addressObject?.locationId =
                                            _territoryItem?.id;
                                        addressObject?.locationName =
                                            _territoryItem?.name;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 17,
                                    ),
                                    CustomTextInputField(
                                      controller: _addressTec,
                                      labelText: "Address",
                                      maxLines: 3,
                                      validator: (value) =>
                                          requiredFieldValidation(value!) != ""
                                              ? requiredFieldValidation(value)
                                              : null,
                                    ),
                                    const SizedBox(
                                      height: 17,
                                    ),
                                    CustomNumberInputField(
                                      controller: _pincodeTec,
                                      inputType: TextInputType.number,
                                      labelText: "Pin Code",
                                      validator: (value) =>
                                          pinFieldValidation(value!) != ""
                                              ? pinFieldValidation(value)
                                              : null,
                                    ),
                                    const SizedBox(
                                      height: 17,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        _currentPosition =
                                            await _determinePosition();
                                        setState(() {
                                          _latLongTec.text =
                                              'Lat : ${_currentPosition!.latitude!.toString()} , Long : ${_currentPosition!.longitude!.toString()}';
                                        });
                                      },
                                      child: CustomNumberInputField(
                                        isAddAddress: true,
                                        enabled: false,
                                        controller: _latLongTec,
                                        labelText: AppStrings.lblGPSCoordinate,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    appCommonFlatButton(
                        btnTxt: AppStrings.lblAddAddress.toUpperCase(),
                        onPressed: () {
                          _sendDataBack(context);
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  void _manageStateStates(state) {
    if (state is StateInAddressSuccessState) {
      _territoryList = [];
      _districtList = [];
      _dropdownStateKey.currentState?.reset();
      _dropdownDistrictKey.currentState?.reset();
      _dropdownTerritoryKey.currentState?.reset();
      //_stateList = state.data;
      state.data.forEach((element) {
        _stateList.add(StateDataItemResponse.fromJson(element));
      });
      if (!widget.isFromRouteInfo) {
        _bloc
            .add(GetDistrictsBaseOnStateEvent(id: addressObject?.stateId ?? 0));
      }
      print('stateslength${_stateList.length}');
    } else {
      showCustomFlushBar(context, state.msg ?? "");
    }
  }

  void _manageDistrictStates(state) {
    if (state is DistrictInAddressSuccessState) {
      _territoryList = [];
      _dropdownDistrictKey.currentState?.reset();
      _dropdownTerritoryKey.currentState?.reset();
      _districtList = state.data;
      if (!widget.isFromRouteInfo) {
        print('passedidS${addressObject?.districtId}');
        _bloc.add(GetLocationBasedOnDistrictEvent(
            id: addressObject?.districtId ?? 0));
      }
      print('_districtlength${_districtList.length}');
    } else {
      showCustomFlushBar(context, state.msg ?? "");
    }
  }

  void _manageTerritoryStates(state) {
    if (state is LocationInAddressSuccessState) {
      _dropdownTerritoryKey.currentState?.reset();
      _territoryList = state.data;
    } else {
      showCustomFlushBar(context, state.msg ?? "");
    }
  }

  Future<void> _sendDataBack(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      addressObject?.pincode = _pincodeTec.text;
      addressObject?.fullAddress = _addressTec.text;
      addressObject?.customerId =
          widget.isFromRouteInfo ? 0 : widget.outletInfo?.id;
      if (_currentPosition != null) {
        addressObject?.latitude = _currentPosition?.latitude.toString();
        addressObject?.longitude = _currentPosition?.longitude.toString();
      }
      if (widget.isFromRouteInfo == false) {
        addressObject?.modifiedOn = getCurrentDateAndTime();
        addressObject?.modifiedBy = await SharedPreferenceService()
            .getIntValuesSF(SharedPrefsConstants.userId);
      } else {
        addressObject?.createdOn = getCurrentDateAndTime();
        addressObject?.createdBy = await SharedPreferenceService()
            .getIntValuesSF(SharedPrefsConstants.userId);
      }
      addressObject?.id = addressObject?.id == null ? 0 : addressObject?.id;
      addressObject?.isActive = true;
      Navigator.pop(context, addressObject);
    }
  }

  void _showConfirmationDialog() {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              content: AppStrings.msgTurnOnLocation,
              title: 'Turn on location',
              yes: AppStrings.lblYes,
              no: AppStrings.lblNo,
              yesOnPressed: () async {
                await Geolocator.openLocationSettings();
              },
              noOnPressed: () {
                Navigator.of(context).pop(false);
                print('alert dialog no clicked');
              },
            ));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showConfirmationDialog();
      //await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
