import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../exports/mixins.dart';
import '../../exports/resources.dart';
import '../../exports/themes.dart';
import '../../exports/widgets.dart';

/// Created by Dev 1051 on 8/11/2021
/// Modified by Dev 1051 on 8/11/2021
/// Purpose : This is a common refresher view. we will use it whenever we need
/// to do pull to refresh and load more.
class CommonRefresher extends StatefulWidget {
  const CommonRefresher(
      {required this.child,
      required this.controller,
      required this.onLoadMore,
      required this.onRefresh,
      this.enablePullUp = true,
      this.enablePullDown = true,
      this.isContentAvailable = true,
      Key? key})
      : super(key: key);
  final Widget child;
  final bool enablePullUp;
  final bool isContentAvailable;
  final bool enablePullDown;
  final RefreshController controller;
  final Function() onRefresh;
  final Function() onLoadMore;

  @override
  _CommonRefresherState createState() => _CommonRefresherState();
}

class _CommonRefresherState extends State<CommonRefresher> with UtilityMixin {
  @override
  Widget build(BuildContext context) {
    if (widget.isContentAvailable) {
      widget.controller.resetNoData();
    }
    return SmartRefresher(
      enablePullUp: widget.enablePullUp,
      enablePullDown: widget.enablePullDown,
      header: getPullToRefreshHeaderWidget(),
      footer: CustomFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        builder: (context, mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text("");
          } else if (mode == LoadStatus.loading) {
            body = CustomLoader.small();
          } else if (mode == LoadStatus.noMore) {
            body = Text(
              AppStrings.noFurtherContentAvailable,
              style: CustomTextStyle.noDataContent,
            );
          } else if (mode == LoadStatus.failed) {
            body = const Text("");
          } else if (mode == LoadStatus.canLoading) {
            body = const Text("");
          } else {
            body = Text(
              AppStrings.noFurtherContentAvailable,
              style: CustomTextStyle.noDataContent,
            );
          }
          return Container(
            height: 55,
            child: Center(child: body),
          );
        },
      ),
      controller: widget.controller,
      onRefresh: () {
        if (!widget.isContentAvailable) {
          widget.controller.resetNoData();
        }
        widget.onRefresh();
      },
      onLoading: () {
        if (!widget.isContentAvailable) {
          widget.controller.loadNoData();
        } else {
          widget.onLoadMore();
        }
      },
      child: widget.child,
    );
  }
}
