import 'package:flutter/material.dart';

import '../../constants/app_enums.dart';
import '../../exports/resources.dart';

/// Created by Dev 2301 on 12/9/2021
/// Modified by Dev 2301 on 12/9/2021
/// Purpose : common request status badge view
class RequestStatusBadge extends StatelessWidget {
  const RequestStatusBadge({required this.status, Key? key}) : super(key: key);
  final RequestStatus? status;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: requestStatusColors[status],
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            requestStatusString(status!),
            style: const TextStyle(color: AppColors.white, fontSize: 10),
          ),
        ),
      );
}

/// Created by Dev 2301 on 12/9/2021
/// Modified by Dev 2301 on 12/9/2021
/// Purpose : hash map for request status label
Map<RequestStatus, String> requestStatusInitials = {
  RequestStatus.approved: "A",
  RequestStatus.pending: "P",
  RequestStatus.rejected: "R",
  RequestStatus.cancelled: "C",
  RequestStatus.needToApply: "",
  RequestStatus.expired: "E",
};

/// Created by Dev 2301 on 12/9/2021
/// Modified by Dev 2301 on 12/9/2021
/// Purpose : hash map for request status color
Map<RequestStatus, dynamic> requestStatusColors = {
  RequestStatus.approved: AppColors.statusApproved,
  RequestStatus.pending: AppColors.statusPending,
  RequestStatus.rejected: AppColors.statusRejected,
  RequestStatus.cancelled: AppColors.statusRejected,
  RequestStatus.expired: AppColors.statusRejected,
};


String requestStatusString(RequestStatus requestStatus) {
  String status;
  switch (requestStatus) {
    case RequestStatus.approved:
      status = "Approved";
      break;
    case RequestStatus.rejected:
      status = "Rejected";
      break;
    case RequestStatus.pending:
      status = "Pending";
      break;
    case RequestStatus.cancelled:
      status = "Canceled";
      break;
    case RequestStatus.expired:
      status = "Expired";
      break;
    default:
      status = "Pending";
      break;
  }
  return status;
}