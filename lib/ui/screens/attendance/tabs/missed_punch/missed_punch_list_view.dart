import 'package:flutter/material.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/app_enums.dart';
import '../../../../../exports/mixins.dart';
import '../../../../../exports/models.dart';
import '../../../../../exports/resources.dart';
import '../../../../../exports/utilities.dart';
import '../../../../../exports/widgets.dart';

/// Created by Dev 2301 on 12/9/2021
/// Modified by Dev 2301 on 12/9/2021
/// Purpose : list view in missed punch page
class MissedPunchListView extends StatelessWidget with UtilityMixin {
  const MissedPunchListView({
    required this.missPunchList,
    required this.onApply,
    Key? key,
  }) : super(key: key);

  final List<MissPunchItem> missPunchList;
  final Function(MissPunchItem) onApply;

  @override
  Widget build(BuildContext context) => _listView();

  Widget _listView() => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: missPunchList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            final item = missPunchList[i];
            return _buildListItemView(item);
          },
        ),
      );

  /// Created by Dev 2301 on 12/9/2021
  /// Modified by Dev 2301 on 12/9/2021
  /// Purpose : list item view

  Widget _buildListItemView(MissPunchItem item) => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [Shadows.greyShadow],
                borderRadius:
                    BorderRadius.circular(AppStyles.commonCardCornerRadius),
              ),
              margin: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: AppStyles.pageSideMargin),
              padding: const EdgeInsets.symmetric(
                  vertical: 30, horizontal: AppStyles.pageSideMargin),
              child: _detailView(item),
            ),
            if (item.missedPunchStatus != RequestStatus.needToApply.index )
              Positioned(
                top: -3,
                right: AppStyles.pageSideMargin,
                child: RequestStatusBadge(
                  status: leaveStatus(item.missedPunchStatus!),
                ),
              ),
            if (item.missedPunchStatus == RequestStatus.needToApply.index ||
                item.missedPunchStatus == RequestStatus.rejected.index)
              Positioned(
                bottom: 0,
                right: AppStyles.pageSideMargin,
                // width: 100,
                child: SizedBox(
                  height: 30,
                  child: appCommonRoundedButton(
                      btnTxt: item.missedPunchStatus ==
                              RequestStatus.needToApply.index
                          ? AppStrings.lblApply
                          : AppStrings.lblReApply,
                      onPressed: () {
                        onApply.call(item);
                      }),
                ),
              )
          ],
        ),
      );

  Widget _detailView(MissPunchItem item) => Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextInputField(
                  labelText: AppStrings.lblDate,
                  initialValue: getDateFromDateTime(
                      item.createdOn!),
                  enabled: false,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: CustomTextInputField(
                  labelText: AppStrings.lblHours,
                  initialValue: item.hours ?? '0',
                  enabled: false,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          if (item.missedPunchStatus != RequestStatus.needToApply.index)
            CustomTextInputField(
              labelText: item.missedPunchStatus == RequestStatus.rejected.index
                  ? AppStrings.lblRejectedReason
              :AppStrings.lblMissedReason,
              initialValue:
                  item.missedPunchStatus == RequestStatus.rejected.index
                      ? item.approverRemark
                      : item.applyReason,
              enabled: false,
            )
        ],
      );

  RequestStatus leaveStatus(int id) {
    RequestStatus status;
    switch (id) {
      case MissPunchFilterId.approved:
        status = RequestStatus.approved;
        break;
      case MissPunchFilterId.rejected:
        status = RequestStatus.rejected;
        break;
      case MissPunchFilterId.pending:
        status = RequestStatus.pending;
        break;
      case MissPunchFilterId.needToApply:
        status = RequestStatus.needToApply;
        break;
      case MissPunchFilterId.expired:
        status = RequestStatus.expired;
        break;
      default:
        status = RequestStatus.pending;
        break;
    }
    return status;
  }
}
