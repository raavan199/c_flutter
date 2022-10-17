import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/payment_collection/payment_collection_bloc.dart';
import '../../../data/models/invoice/invoice_item.dart';
import '../../../data/models/invoice/invoice_statement_item.dart';
import '../../../data/models/invoice/order_invoice_mapping.dart';
import '../../../data/models/sales_return/sales_return_item.dart';
import '../../../exports/constants.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../../../services/shared_preference_service.dart';
import '../../../utilities/shadow.dart';
import '../../widgets/custom_dropdown_invoice.dart';
import '../../widgets/custom_number_input.dart';
import '../add_new_order/product_price_calculation.dart';
import '../base/base_screen.dart';

/// Created by Dev 2136 on 02/12/2021
/// Modified by Dev 2136 on 02/12/2021
/// Purpose : payment collection screen of the app
class PaymentCollectionScreen extends StatefulWidget {
  CustomerDataItemsResponse? outletInfo;
  OrderInvoiceMapping? selectedInvoice;

  PaymentCollectionScreen(
      {required this.outletInfo, required this.selectedInvoice, Key? key})
      : super(key: key);

  @override
  _PaymentCollectionScreenState createState() =>
      _PaymentCollectionScreenState();
}

class _PaymentCollectionScreenState extends State<PaymentCollectionScreen>
    with UtilityMixin, ValidationMixin {
  final List<RadioSelectionItemModel> _radioSelectionList = [
    RadioSelectionItemModel(
      AppStrings.lblCheque,
      isSelected: true,
      id: PaymentModeId.cheque,
    ),
    RadioSelectionItemModel(
      AppStrings.lblOnline,
      id: PaymentModeId.UPI,
    ),
    RadioSelectionItemModel(
      AppStrings.lblCash,
      id: PaymentModeId.cash,
    ),
  ];
  int userId = 0;
  double previousAmount = 0.0;
  double totalAdjustmentValue = 0.0;
  late PaymentCollectionBloc _bloc;
  List<OrderInvoiceMapping> _orderInvoiceMappingList = [];
  final _dropdownKey = GlobalKey<FormFieldState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  RadioSelectionItemModel? selectedItem;

  @override
  Widget build(BuildContext context) => BaseScreen<PaymentCollectionBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        _bloc.add(GetInvoicesFromDB(customerId: widget.outletInfo!.id!));
      },
      builder: (context, bloc, child) =>
          BlocListener<PaymentCollectionBloc, BaseState>(
            listener: (context, state) {
              if (state is GetInvoicesSuccessState) {
                _orderInvoiceMappingList = state.data;
                _dropdownKey.currentState?.reset();
                _bloc.add(GetLatestInvoiceStatement(
                    invoiceId: widget.selectedInvoice!.id));
              } else if (state is GetInvoicesFailedState) {
              } else if (state is PostInvoiceStatementSuccessState) {
                Navigator.pop(context, true);
              } else if (state is PostInvoiceStatementFailedState) {
              } else if (state is LatestInvoiceStatementSuccessState) {
                if (state.latestInvoiceStatement != null) {
                  setState(() {
                    previousAmount = state.latestInvoiceStatement.amount;
                  });
                }
                if (state.approvedSalesReturn != null &&
                    state.approvedSalesReturn.isNotEmpty) {
                  var price = 0.0;
                  var totalTax = 0.0;
                  for (final element
                      in state.approvedSalesReturn as List<SalesReturnItem>) {
                    price = price +
                        ProductPriceCalculation.calculatePriceOfProduct(
                            element.rate ?? 1,
                            element.sellableQuantity?.toDouble() ?? 1);
                    price = price +
                        ProductPriceCalculation.calculatePriceOfProduct(
                            element.rate ?? 1,
                            element.damagedQuantity?.toDouble() ?? 1);
                    totalTax = totalTax +
                        ProductPriceCalculation.calculateTotalTaxWithPrice(
                            element.rate ?? 1,
                            element.sellableQuantity ?? 1,
                            element.igst ?? 1,
                            0.0);
                    totalTax = totalTax +
                        ProductPriceCalculation.calculateTotalTaxWithPrice(
                            element.rate ?? 1,
                            element.damagedQuantity ?? 1,
                            element.igst ?? 1,
                            0.0);
                  }
                  setState(() {
                    totalAdjustmentValue = totalTax + price;
                  });
                }
              } else if (state is LatestInvoiceStatementFailedState) {}
            },
            child: Scaffold(
              appBar: CustomAppBar(
                hasBack: true,
                title: AppStrings.lblPaymentCollection,
              ),
              body: CommonContainer(
                hasTimer: true,
                topLayout: CommonDetailedHeader(
                  hasExtraPadding: true,
                  screenName: '',
                  outletName: widget.outletInfo?.businessName,
                  retailerType: widget.outletInfo?.customerTypeName,
                  retailerLocation: widget.outletInfo?.routeName,
                ),
                child: SafeArea(
                  child: _buildPaymentCollectionView(),
                ),
              ),
            ),
          ));

  Widget _buildPaymentCollectionView() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                  AppStyles.pageSideMargin,
                  30,
                  AppStyles.pageSideMargin,
                  20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NameNumberWidget(
                        retailerName: widget.outletInfo?.contactPersonName!,
                        number: widget.outletInfo?.mobileNumber!),
                    const SizedBox(height: 20),
                    CustomDropDownInvoice(
                      labelText: AppStrings.lblUnpaidInvoice,
                      items: _orderInvoiceMappingList,
                      iconPath: AppAssets.icDropDownArrow,
                      onItemSelected: (selectedValue) {
                        setState(() {
                          widget.selectedInvoice =
                              _orderInvoiceMappingList.firstWhere(
                                  (element) => element.id == selectedValue);
                          previousAmount = 0.0;
                          totalAdjustmentValue = 0.0;
                          _bloc.add(GetInvoicesFromDB(
                              customerId: widget.outletInfo!.id!));
                        });
                      },
                      initialValue: widget.selectedInvoice,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _balanceSheetView(),
                    const SizedBox(
                      height: 20,
                    ),
                    _paymentModeText(),
                    Row(
                      children: [
                        Expanded(
                          child: RadioSelectionView(
                            list: _radioSelectionList,
                            hasDecoration: false,
                            hasSpaceBetween: false,
                            fontSize: 12,
                            fontWeight: AppFonts.medium,
                            onItemChanged: (data) {
                              selectedItem = data;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _amountView(),
                            const SizedBox(
                              height: 15,
                            ),
                            _transactionReferenceView(),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    _remainingAmount(),
                  ],
                ),
              ),
            ),
          ),
          _bottomButtonView(),
        ],
      );

  Widget _balanceSheetView() =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [Shadows.greyShadow],
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '${AppStrings.lblInvoiceDate} :',
                    style: TextStyle(fontSize: 11),
                  ),
                  Text(
                    getDateFromDateTime(widget.selectedInvoice!.date),
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '${AppStrings.lblInvoiceAmount} :',
                    style: TextStyle(fontSize: 11),
                  ),
                  Text(
                    '${AppStrings.inr} ${getTotalAmountOfInvoices(
                        widget.selectedInvoice!.secondaryInvoiceItems!)
                        .toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '${AppStrings.lblPreviousPayment} :',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: AppFonts.extraBold,
                        color: AppColors.primary),
                  ),
                  Text(
                    '${AppStrings.inr} $previousAmount',
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '${AppStrings.lblReturnAdjustment} :',
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    '${AppStrings.inr} ${totalAdjustmentValue.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '${AppStrings.lblBalanceAmount} :',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: AppFonts.extraBold,
                    ),
                  ),
                  Text(
                    '${AppStrings.inr} ${(getTotalAmountOfInvoices(
                        widget.selectedInvoice!.secondaryInvoiceItems!) -
                        getTotalOfPaymentForInvoices(
                            widget.selectedInvoice!.invoiceStatementItems) -
                        totalAdjustmentValue).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _paymentModeText() =>
      const Text(
        AppStrings.lblPaymentMode,
        style: TextStyle(
          fontSize: 14,
          fontWeight: AppFonts.extraBold,
        ),
      );

  Widget _amountView() => CustomNumberInputField(
      validator: (value) => collectionAmountFieldValidation(
          value!,
          getTotalAmountOfInvoices(
                  widget.selectedInvoice!.secondaryInvoiceItems!) -
              getTotalOfPaymentForInvoices(
                  widget.selectedInvoice!.invoiceStatementItems)),
      labelText: AppStrings.lblAmount,
      controller: _amountController,
      inputType: TextInputType.number);

  Widget _transactionReferenceView() =>
      CustomTextInputField(
        labelText: AppStrings.lblTransactionReference,
        controller: _referenceController,
      );

  Widget _remainingAmount() =>
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${AppStrings.lblRemainingAmount} : ${AppStrings
                .inr} ${(getTotalAmountOfInvoices(
                widget.selectedInvoice!.secondaryInvoiceItems!) -
                getTotalOfPaymentForInvoices(
                    widget.selectedInvoice!.invoiceStatementItems))
                .toStringAsFixed(2)}',
            style: const TextStyle(color: AppColors.red),
          )
        ],
      );

  Widget _bottomButtonView() =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: appCommonFlatButton(
              btnTxt: AppStrings.lblAccounts.toUpperCase(),
              isTopRightRounded: false,
              onPressed: _onAccounts,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Expanded(
              child: appCommonFlatButton(
                btnTxt: AppStrings.lblCollect.toUpperCase(),
                isTopLeftRounded: false,
                onPressed: _onCollect,
              )),
        ],
      );

  void _onAccounts() {
    Navigator.of(context).pop();
  }

  Future<void> _onCollect() async {
    if (_formKey.currentState?.validate() ?? false) {
      userId = await SharedPreferenceService()
          .getIntValuesSF(SharedPrefsConstants.userId);
      var visitId = await SharedPreferenceService()
          .getIntValuesSF(SharedPrefsConstants.visitId);
      if (visitId == null || visitId == 0) {
        visitId = await SharedPreferenceService()
            .getIntValuesSF(SharedPrefsConstants.scopeId);
      }
      var id = 0;
      for (var i = 0; i < _radioSelectionList.length; i++) {
        if (_radioSelectionList[i].isSelected) {
          id = _radioSelectionList[i].id ?? 0;
        }
      }
      var invoiceStatement = InvoiceStatementItem(id: generateRandomNumber(),
          createdBy: userId,
          createdOn: getCurrentDateAndTime(),
          customerId: widget.outletInfo!.id!,
          invoiceId: widget.selectedInvoice!.id,
          paidBy: id,
          referenceNumber: _referenceController.text,
          amount: double.tryParse(_amountController.text),
          distributorId: widget.selectedInvoice!.distributorId,
          subscriberId: widget.selectedInvoice!.subscriberId,
          fyId: 1, //updating value in bloc event
          jcId: 1, // updating value in bloc event
          isSync: SyncStatus.unSync,
      visitId: visitId);

      /*InvoiceStatementItem(
          generateRandomNumber(),
          userId,
          getCurrentDateAndTime(),
          null,
          null,
          widget.outletInfo!.id!,
          widget.selectedInvoice!.id,
          userId,
          _referenceController.text,
          double.tryParse(_amountController.text),
          widget.selectedInvoice!.distributorId,
          widget.selectedInvoice!.subscriberId,
          1,
          1,
          SyncStatus.unSync);*/
      _bloc.add(AddCollectedPayment(invoiceStatement: invoiceStatement));
    }
  }

  double getTotalOfPaymentForInvoices(List<InvoiceStatementItem>? items) {
    var _totalPaymentDone = 0.0;
    if (items != null) {
      for (final element in items) {
        _totalPaymentDone = _totalPaymentDone + element.amount!;
      }
    }
    return _totalPaymentDone;
  }

  double getTotalAmountOfInvoices(List<InvoiceItem> items) {
    var price = 0.0;
    var totalTax = 0.0;
    var discount = 0.0;
    for (final element in items) {
      price = price +
          ProductPriceCalculation.calculatePriceOfProduct(
              element.basePrice ?? 1, element.billQuantity?.toDouble() ?? 1);
      var intDiscount = 0.0;
      if (element.discount != null && element.discount != 0.0) {
        intDiscount = ProductPriceCalculation.calculateDiscountValue(
            element.basePrice!,
            element.discount!,
            element.billQuantity!.roundToDouble());
        discount = discount + intDiscount;
      }
      totalTax = totalTax +
          ProductPriceCalculation.calculateTotalTaxWithPrice(
              element.basePrice ?? 1,
              element.billQuantity?.toDouble() ?? 1,
              element.igst ?? 1,
              intDiscount);
    }
    return price + totalTax - discount;
  }
}
