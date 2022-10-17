import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/cart/cart_bloc.dart';
import '../../../constants/app_constants.dart';
import '../../../data/models/order_item/order_item_data_response.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../../../services/api/api_service.dart';
import '../../../services/shared_preference_service.dart';
import '../../widgets/custom_dialog.dart';
import '../Cart/cart_list_view.dart';
import '../add_new_order/product_price_calculation.dart';
import '../base/base_screen.dart';
import '../outlet_info/outlet_info_screen.dart';

class ActivityDetailScreen extends StatefulWidget {
  const ActivityDetailScreen({
    required this.data,
    Key? key,
  }) : super(key: key);

  final ActivityRegisteredItem data;

  @override
  _ActivityDetailScreenState createState() => _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends State<ActivityDetailScreen>
    with UtilityMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(
          hasBack: true,
          title: AppStrings.lblActivityHistory,
        ),
        body: SafeArea(
          child: CommonContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [Shadows.greyShadow],
                              borderRadius: BorderRadius.circular(
                                  AppStyles.commonCardCornerRadius),
                            ),
                            padding: const EdgeInsets.fromLTRB(15, 35, 15, 15),
                            child: Column(
                              children: [
                                _TextField(AppStrings.lblActivityType,
                                    widget.data.activityTypeName
                                  ),
                                const SizedBox(
                                  height: 8,
                                ),
                                _TextField(AppStrings.lblStartTime,
                                    get12HTimeString(widget.data.startTime!)),
                                const SizedBox(
                                  height: 8,
                                ),
                                _TextField(AppStrings.lblEndTime,
                                    get12HTimeString(widget.data.endTime!)),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _textWidget(AppStrings.lblActivity,
                                        CustomTextStyle.imageDetailsTextStyle),
                                    const Text(' :  '),
                                    Flexible(
                                      child: Text(
                                        widget.data.details ?? "",
                                        style: CustomTextStyle.smallTextStyle,
                                        maxLines: 5,
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              top: -7,
                              left: Get.width / 3,
                              child: Container(
                                decoration:
                                    BoxDecoration(
                                      color: AppColors.primary,
                                      boxShadow: const [Shadows.greyShadow],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                                child: Text(getDateFromDateTime(
                                    widget.data.date!,
                                    format: DateFormats.ddMMyyyyDash),
                                style: CustomTextStyle.buttonTextStyle),
                              )),
                        ],
                      )),
                )),
              ],
            ),
          ),
        ),
      );

  Widget _TextField(String textTitle, String? value,
          [TextStyle? titleTextStyle, TextStyle? valueTextStyle]) =>
      Row(
        children: [
          _textWidget(textTitle,
              titleTextStyle ?? CustomTextStyle.imageDetailsTextStyle),
          const Text(' :  '),
          Visibility(
              visible: value != null,
              child: _textWidget(value ?? "",
                  titleTextStyle ?? CustomTextStyle.smallTextStyle))
        ],
      );

  Widget _textWidget(String text, TextStyle? style) => Text(
        text,
        style: style ?? CustomTextStyle.smallTextStyle,
        maxLines: 2,
        textAlign: TextAlign.justify,
        overflow: TextOverflow.ellipsis,
      );

  @override
  void dispose() {
    super.dispose();
  }
}
