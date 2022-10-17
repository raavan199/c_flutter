import 'package:cygneto/exports/mixins.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/leave/leave_balance.dart';
import '../../../../../data/models/leave/leave_item.dart';
import '../../../../../exports/constants.dart';
import '../../../../../exports/resources.dart';
import '../../../../../exports/themes.dart';
import '../../../../../exports/utilities.dart';
import '../../../../../exports/widgets.dart';

/// Created by Dev 2301 on 12/9/2021
/// Modified by Dev 2301 on 12/9/2021
/// Purpose : applied leaves list view in leaves page
class AppliedLeavesListView extends StatelessWidget with UtilityMixin {

  const AppliedLeavesListView({
    required this.list,
    required this.leaveTypes,
    required this.onItemTap,
    required this.onCancel,
    Key? key,
  }) : super(key: key);

  final Function(LeaveItem) onItemTap;
  final Function(LeaveItem) onCancel;
  final List<LeaveItem> list;
  final List<LeaveBalance> leaveTypes;

  @override
  Widget build(BuildContext context) => _listView();

  Widget _listView() => ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          final item = list[i];
          return _buildListItemView(item);
        },
      );

  /// Created by Dev 2301 on 12/9/2021
  /// Modified by Dev 2301 on 12/9/2021
  /// Purpose : list item view

  Widget _buildListItemView(LeaveItem item) => Padding(
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
            Positioned(
              top: -7,
              left: AppStyles.pageSideMargin,
              child: RequestStatusBadge(
                status: leaveStatus(item.leaveStatus ?? 0),
              ),
            ),
            if (item.leaveStatus == LeaveStatusId.pending)
              Positioned(
                top: -7,
                right: AppStyles.pageSideMargin,
                child: Container(
                    decoration:
                        const BoxDecoration(boxShadow: [Shadows.blueShadow]),
                    child: _close(item)),
              ),
          ],
        ),
      );

  String LeaveTypeName(int leaveTypeId) {
    var leaveType = '';
    for (var i = 0; i < leaveTypes.length; i++) {
      if (leaveTypes[i].id == leaveTypeId) {
        leaveType = leaveTypes[i].leaveTypeName!;
      }
    }

    return leaveType;
  }

  RequestStatus leaveStatus(int id) {
    RequestStatus status;
    switch (id) {
      case LeaveStatusId.approved:
        status = RequestStatus.approved;
        break;
      case LeaveStatusId.rejected:
        status = RequestStatus.rejected;
        break;
      case LeaveStatusId.pending:
        status = RequestStatus.pending;
        break;
      case LeaveStatusId.cancelled:
        status = RequestStatus.cancelled;
        break;
      default:
        status = RequestStatus.pending;
        break;
    }
    return status;
  }

  Widget _detailView(LeaveItem item){
    TextEditingController _textControler = new TextEditingController();
    if(item.leaveStatus == LeaveStatusId.approved || item.leaveStatus == LeaveStatusId.rejected) {
      _textControler.text = item.approverRemark ?? "";
    } else{
      _textControler.text = item.remarks ?? '';
    }
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _dateItem(AppStrings.lblFromDate,
                  getDateFromDateTime(item.fromDate!)),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: _dateItem(
                  AppStrings.lblToDate, getDateFromDateTime(item.toDate!)),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: _dateItem(
                  AppStrings.lblLeaveType, LeaveTypeName(item.leaveTypeId!)),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextInputField(
          labelText: AppStrings.lblRemarks,
          controller: _textControler,
          enabled: false,
        )
      ],
    ) ;
  }

  Widget _dateItem(String title, String value) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: CustomTextStyle.smallTextStyle,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius:
                  BorderRadius.circular(AppStyles.commonCardCornerRadius),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
            child: Text(
              value,
              style: CustomTextStyle.smallTextStyle,
            ),
          ),
        ],
      );

  Widget _close(LeaveItem item) => InkWell(
        onTap: () {
          onCancel(item);
        },
        child: const CircleAvatar(
          backgroundColor: AppColors.primary,
          radius: 13,
          child: Icon(
            Icons.clear,
            color: AppColors.white,
          ),
        ),
      );
}
