import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../blocs/analysis/analysis_bloc.dart';
import '../../../blocs/base/base_bloc.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../../../mixins/utility_mixin.dart';
import '../base/base_screen.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({this.customerInfo, this.lastVisit, Key? key})
      : super(key: key);

  final CustomerDataItemsResponse? customerInfo;
  final VisitDataItemsResponse? lastVisit;

  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> with UtilityMixin {
  late AnalysisBloc _bloc;
  List<InvoiceItem>? _currentFyDataList = [];
  List<InvoiceItem>? _currentJcDataList = [];
  List<InvoiceItem>? _prevFyDataList = [];
  List<InvoiceItem>? _prevJcDataList = [];
  double currentFyAmount = 0;
  double currentJcAmount = 0;
  double prevFyAmount = 0;
  double prevJcAmount = 0;
  String? lastOrderDate = "";
  double? lastOrderValue = 0;
  double currentFyAmountForSingleVisit = 0;
  double currentJcAmountSingleVisit = 0;
  double currentFyAmountForJointVisit = 0;
  double currentJcAmountJointVisit = 0;
  double prevFyAmountForSingleVisit = 0;
  double prevJcAmountSingleVisit = 0;
  double prevFyAmountForJointVisit = 0;
  double prevJcAmountJointVisit = 0;
  List<OrderModel> orderArray = [
    OrderModel(
      label: 'Order Value(Current)',
      fytd: 'Current. FYTD',
      jc: 'Current. JC',
    ),
    OrderModel(
      label: 'Order Value(Prev.)',
      fytd: 'Prev. FYTD',
      jc: 'Prev. JC',
    )
  ];

  List<VisitModel> visitArray = [
    VisitModel(
      visitType: 'Single Visits',
    ),
    VisitModel(
      visitType: 'Joint Visits',
    ),
  ];

  @override
  Widget build(BuildContext context) => BaseScreen<AnalysisBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        _bloc.add(GetCurrentFyDataFromDatabaseEvent(
            customerId: widget.customerInfo?.id ?? 0));
      },
      builder: (context, bloc, child) => BlocListener<AnalysisBloc, BaseState>(
          listener: (context, state) {
            if (state is CurrentFyDataSuccessState ||
                state is CurrentFyDataFailedState) {
              _manageCurrentFyState(state);
            } else if (state is CurrentJcDataSuccessState ||
                state is CurrentJcDataFailedState) {
              _manageCurrentJcState(state);
            } else if (state is PrevFyDataSuccessState ||
                state is PrevFyDataFailedState) {
              _managePrevFyState(state);
            } else if (state is PrevJcDataSuccessState ||
                state is PrevJcDataFailedState) {
              _managePrevJcState(state);
            }
          },
          child: Scaffold(
            appBar: CustomAppBar(
              title: AppStrings.lblANALYSIS,
            ),
            drawer: const AppDrawer(
              selectedIndex: 2,
            ),
            body: CommonContainer(
              topLayout: CommonDetailedHeader(
                outletName: widget.customerInfo?.businessName,
                retailerType: widget.customerInfo?.customerTypeName,
                retailerLocation: widget.customerInfo?.routeName,
                screenName: "",
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  NameNumberWidget(
                    retailerName: widget.customerInfo?.contactPersonName,
                    number: widget.customerInfo?.mobileNumber,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _orderDetailView(),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 1,
                    color: AppColors.border,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _lastOrderView(),
                  const SizedBox(
                    height: 20,
                  ),
                  _singleVisitsView(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )));

  void _manageCurrentFyState(state) {
    _bloc.add(GetCurrentJcData(
      customerId: widget.customerInfo?.id ?? 0,
      currentDate: convertDateForPassInQueryFormat(DateTime.now()),
    ));
    if (state is CurrentFyDataSuccessState) {
      if (state.data != null) {
        state.data.forEach((v) {
          _currentFyDataList?.add(InvoiceItem.fromJsonForRowQuery(v));
          final totalAmount =
              calculateTotalPrice(InvoiceItem.fromJsonForRowQuery(v));
          final totalTax = calculateTotalTaxWithPrice(
              totalAmount, InvoiceItem.fromJsonForRowQuery(v));
          final totalDiscount =
              calculateTotalDiscount(InvoiceItem.fromJsonForRowQuery(v));
          lastOrderDate = InvoiceItem.fromJsonForRowQuery(v).createdOn;
          lastOrderValue =
              calculatePayableAmount(totalAmount, totalDiscount, totalTax);
          currentFyAmount = currentFyAmount +
              calculatePayableAmount(totalAmount, totalDiscount, totalTax);
          if (InvoiceItem.fromJsonForRowQuery(v).partnerId == null) {
            currentFyAmountForSingleVisit = currentFyAmountForSingleVisit +
                calculatePayableAmount(totalAmount, totalDiscount, totalTax);
          } else {
            currentFyAmountForJointVisit = currentFyAmountForJointVisit +
                calculatePayableAmount(totalAmount, totalDiscount, totalTax);
          }
        });
        orderArray[0].fytdAmount = currentFyAmount.toString();
        visitArray[0].currentFytdAmount =
            currentFyAmountForSingleVisit.toString();
        visitArray[1].currentFytdAmount =
            currentFyAmountForJointVisit.toString();
      }
    } else {}
  }

  void _manageCurrentJcState(state) {
    _bloc.add(GetPrevFyData(
        customerId: widget.customerInfo?.id ?? 0,
        currentDate: convertDateForPassInQueryFormat(DateTime.now())));
    if (state is CurrentJcDataSuccessState) {
      if (state.data != null) {
        state.data.forEach((v) {
          _currentJcDataList?.add(InvoiceItem.fromJsonForRowQuery(v));
          final totalAmount =
              calculateTotalPrice(InvoiceItem.fromJsonForRowQuery(v));
          final totalTax = calculateTotalTaxWithPrice(
              totalAmount, InvoiceItem.fromJsonForRowQuery(v));
          final totalDiscount =
              calculateTotalDiscount(InvoiceItem.fromJsonForRowQuery(v));
          currentJcAmount = currentJcAmount +
              calculatePayableAmount(totalAmount, totalDiscount, totalTax);
          if (InvoiceItem.fromJsonForRowQuery(v).partnerId == null) {
            currentJcAmountSingleVisit = currentJcAmountSingleVisit +
                calculatePayableAmount(totalAmount, totalDiscount, totalTax);
          } else {
            currentJcAmountJointVisit = currentJcAmountJointVisit +
                calculatePayableAmount(totalAmount, totalDiscount, totalTax);
          }
        });
        orderArray[0].jcAmount = currentJcAmount.toString();
        visitArray[0].currentJcAmount = currentJcAmountSingleVisit.toString();
        visitArray[1].currentJcAmount = currentJcAmountJointVisit.toString();
      }
    } else {}
  }

  void _managePrevFyState(state) {
    _bloc.add(GetPrevJcData(
        customerId: widget.customerInfo?.id ?? 0,
        currentDate: convertDateForPassInQueryFormat(DateTime.now())));
    if (state is PrevFyDataSuccessState) {
      if (state.data != null) {
        state.data.forEach((v) {
          _prevFyDataList?.add(InvoiceItem.fromJsonForRowQuery(v));
          final totalAmount =
              calculateTotalPrice(InvoiceItem.fromJsonForRowQuery(v));
          final totalTax = calculateTotalTaxWithPrice(
              totalAmount, InvoiceItem.fromJsonForRowQuery(v));
          final totalDiscount =
              calculateTotalDiscount(InvoiceItem.fromJsonForRowQuery(v));
          prevFyAmount = prevFyAmount +
              calculatePayableAmount(totalAmount, totalDiscount, totalTax);
          if (InvoiceItem.fromJsonForRowQuery(v).partnerId == null) {
            prevFyAmountForSingleVisit = prevFyAmountForSingleVisit +
                calculatePayableAmount(totalAmount, totalDiscount, totalTax);
          } else {
            prevFyAmountForJointVisit = prevFyAmountForJointVisit +
                calculatePayableAmount(totalAmount, totalDiscount, totalTax);
          }
        });
        orderArray[1].fytdAmount = prevFyAmount.toString();
        visitArray[0].prevFytdAmount = prevFyAmountForSingleVisit.toString();
        visitArray[1].prevFytdAmount = prevFyAmountForJointVisit.toString();
      }
    } else {}
  }

  void _managePrevJcState(state) {
    if (state is PrevJcDataSuccessState) {
      if (state.data != null) {
        state.data.forEach((v) {
          _prevJcDataList?.add(InvoiceItem.fromJsonForRowQuery(v));
          final totalAmount =
              calculateTotalPrice(InvoiceItem.fromJsonForRowQuery(v));
          final totalTax = calculateTotalTaxWithPrice(
              totalAmount, InvoiceItem.fromJsonForRowQuery(v));
          final totalDiscount =
              calculateTotalDiscount(InvoiceItem.fromJsonForRowQuery(v));
          prevJcAmount = prevJcAmount +
              calculatePayableAmount(totalAmount, totalDiscount, totalTax);
          if (InvoiceItem.fromJsonForRowQuery(v).partnerId == null) {
            prevJcAmountSingleVisit = prevJcAmountSingleVisit +
                calculatePayableAmount(totalAmount, totalDiscount, totalTax);
          } else {
            prevJcAmountJointVisit = prevJcAmountJointVisit +
                calculatePayableAmount(totalAmount, totalDiscount, totalTax);
          }
        });
        orderArray[1].jcAmount = prevJcAmount.toString();
        visitArray[0].prevJcAmount = prevJcAmountSingleVisit.toString();
        visitArray[1].prevJcAmount = prevJcAmountJointVisit.toString();
      }
    } else {}
  }

  static double calculateTotalPrice(InvoiceItem invoiceItem) =>
      (invoiceItem.basePrice ?? 0) * (invoiceItem.billQuantity ?? 0);

  static double calculateTotalDiscount(InvoiceItem invoiceItem) {
    var discount = 0.0;
    if (invoiceItem.discount != null && invoiceItem.discount != 0) {
      discount = (invoiceItem.billQuantity ?? 0).toDouble() *
          (invoiceItem.discount)!.toDouble();
    }

    /*if (invoiceItem.selected_scheme_id != null &&
        invoiceItem.scheme_discount != null) {
      var priceBeforeSchemeDiscount =
          calculateTotalPrice(invoiceItem) - discount;

      priceBeforeSchemeDiscount =
          (priceBeforeSchemeDiscount * invoiceItem.scheme_discount!) / 100;

      discount = discount + priceBeforeSchemeDiscount;
    }*/
    return discount;
  }

  static double calculateTotalTaxWithPrice(
      double totalAmount, InvoiceItem invoiceItem) {
    if (invoiceItem.igst != null || invoiceItem.igst != 0) {
      return (totalAmount * invoiceItem.igst!) / 100;
    }
    return 0;
  }

  static double calculatePayableAmount(
          double totalAmount, double totalDiscount, double totalTax) =>
      totalAmount + totalTax - totalDiscount;

  Widget _orderDetailView() => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 130,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(
                  width: 0,
                ),
            itemCount: orderArray.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        alignment: Alignment.center,
                        color: AppColors.primary,
                        width: 190,
                        height: 35,
                        child: Text(
                          orderArray[index].label ?? "",
                          style: const TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [Shadows.greyShadow],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: 300,
                            padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      orderArray[index].fytd ?? "",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: AppFonts.extraBold,
                                      ),
                                    ),
                                    Text(
                                      orderArray[index].fytdAmount ?? "",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: AppFonts.extraBold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      orderArray[index].jc ?? "",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: AppFonts.extraBold,
                                      ),
                                    ),
                                    Text(
                                      orderArray[index].jcAmount ?? "",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: AppFonts.extraBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: -20,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                boxShadow: [Shadows.greyShadow],
                              ),
                              height: 45,
                              width: 45,
                              child: SvgPicture.asset(
                                AppAssets.icHandPoint,
                                height: 15,
                                width: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
      );

  Widget _lastOrderView() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '${AppStrings.lastOrder} : ',
            style: TextStyle(
              fontSize: 13,
              fontWeight: AppFonts.extraBold,
              letterSpacing: 0.05,
            ),
          ),
          Text(
            getDateFromDateTime(lastOrderDate ?? 'N/A'),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: AppFonts.normal,
              letterSpacing: 0.05,
            ),
          ),
          const Text(
            ' | ${AppStrings.orderValue}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: AppFonts.extraBold,
              letterSpacing: 0.05,
            ),
          ),
          Text(
            lastOrderValue.toString(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: AppFonts.normal,
              letterSpacing: 0.05,
            ),
          ),
        ],
      );

  Widget _singleVisitsView() => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(
                  width: 0,
                ),
            itemCount: visitArray.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        alignment: Alignment.center,
                        color: AppColors.primary,
                        width: 145,
                        height: 35,
                        child: Text(
                          visitArray[index].visitType,
                          style: const TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [Shadows.greyShadow],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: 300,
                            padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Prev. FYTD',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: AppFonts.extraBold,
                                      ),
                                    ),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: AppFonts.extraBold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Cur. FYTD',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: AppFonts.extraBold,
                                      ),
                                    ),
                                    Text(
                                      visitArray[index].currentFytdAmount!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: AppFonts.extraBold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 1,
                                  color: AppColors.border,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Prev. JC',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: AppFonts.extraBold,
                                      ),
                                    ),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: AppFonts.extraBold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Cur. JC',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: AppFonts.extraBold,
                                      ),
                                    ),
                                    Text(
                                      visitArray[index].currentJcAmount!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: AppFonts.extraBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 50,
                            right: -20,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                boxShadow: [Shadows.greyShadow],
                              ),
                              height: 45,
                              width: 45,
                              child: SvgPicture.asset(
                                AppAssets.icHandPoint,
                                height: 15,
                                width: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
      );
}

class OrderModel {
  OrderModel({
    required this.label,
    required this.fytd,
    required this.jc,
    this.fytdAmount,
    this.jcAmount,
  });

  String label;
  String fytd;
  String jc;
  String? fytdAmount;
  String? jcAmount;
}

class VisitModel {
  VisitModel({
    required this.visitType,
    this.prevFytdAmount,
    this.currentFytdAmount,
    this.prevJcAmount,
    this.currentJcAmount,
  });

  String visitType;
  String? prevFytdAmount;
  String? currentFytdAmount;
  String? prevJcAmount;
  String? currentJcAmount;
}
