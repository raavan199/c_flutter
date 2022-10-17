import 'package:flutter/material.dart';

import '../../exports/models.dart';
import '../../exports/resources.dart';
import '../../mixins/utility_mixin.dart';
import '../../resources/app_styles.dart';
import 'search_widget.dart';
import 'timer_widget.dart';

/// Created by Dev 2301 on 12/14/2021
/// Modified by Dev 2301 on 12/14/2021
/// Purpose : common container used throughout the app
class CommonContainer extends StatefulWidget with UtilityMixin {
  const CommonContainer({
    required this.child,
    this.topLayout,
    this.isSearchable = false,
    this.showInternetAlert = false,
    this.hasTimer = false,
    this.searchData,
    this.searchHint,
    this.onSearchResult,
    this.stopTimer = false,
    Key? key,
  }) : super(key: key);

  final Widget? topLayout;
  final Widget child;
  final bool isSearchable;
  final bool hasTimer;
  final bool showInternetAlert;
  final List<SearchModel>? searchData;
  final String? searchHint;
  final Function(List<SearchModel>)? onSearchResult;
  final bool stopTimer;

  @override
  State<CommonContainer> createState() => _CommonContainerState();
}

class _CommonContainerState extends State<CommonContainer> {
  @override
  Widget build(BuildContext context) => Container(
        color: AppColors.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            widget.topLayout ??
                const SizedBox(
                  height: 10,
                ),
            if (widget.showInternetAlert)
              const SizedBox(
                height: 30,
              ),
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(AppStyles.commonCornerRadius),
                              topRight:
                                  Radius.circular(AppStyles.commonCornerRadius)),
                          child: Container(
                            decoration: AppStyles.commonContainer,
                            child: widget.child,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: widget.hasTimer,
                    child: Positioned(
                      key: UniqueKey(),
                        top: 8,
                        left: AppStyles.pageSideMargin,
                        child: TimerWidget(
                          startTimer: widget.hasTimer,
                          cancelTimer: widget.stopTimer,
                        )),
                  ),
                  if (widget.isSearchable)
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SearchWidget(
                            dataList: widget.searchData!,
                            onResult: widget.onSearchResult!,
                            searchHint: widget.searchHint ?? 'search',
                          ),
                        ),
                      ),
                  if (widget.showInternetAlert)
                    Positioned(
                      top: -10,
                      child: Container(
                        //height: 90,
                        decoration: BoxDecoration(
                          color: AppColors.accentYellow,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColors.border),
                        ),
                        width: MediaQuery.of(context).size.width - 40,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          text: const TextSpan(
                            text: 'Alert -  ',
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0.05,
                              fontWeight: AppFonts.extraBold,
                              color: AppColors.red,
                            ),
                            children: [
                              TextSpan(
                                text: AppStrings.msgDoNotOffInternet,
                                style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 0.05,
                                  fontWeight: AppFonts.extraBold,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      );
}
