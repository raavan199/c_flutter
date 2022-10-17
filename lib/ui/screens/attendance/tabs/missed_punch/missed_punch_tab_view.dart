import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../blocs/base/base_bloc.dart';
import '../../../../../blocs/miss_punch/miss_punch_bloc.dart';
import '../../../../../exports/constants.dart';
import '../../../../../exports/mixins.dart';
import '../../../../../exports/models.dart';
import '../../../../../exports/resources.dart';
import '../../../../../exports/widgets.dart';
import '../../../../../services/api/api_service.dart';
import '../../../base/base_screen.dart';
import '../../apply_missed_punch_screen.dart';
import 'missed_punch_list_view.dart';

/// Created by Dev 2301 on 12/9/2021
/// Modified by Dev 2301 on 12/9/2021
/// Purpose : missed punch tab view in Attendance screen
class MissedPunchTabView extends StatefulWidget {
  const MissedPunchTabView({Key? key}) : super(key: key);

  @override
  _MissedPunchTabViewState createState() => _MissedPunchTabViewState();
}

class _MissedPunchTabViewState extends State<MissedPunchTabView>
    with UtilityMixin {
  List<MissPunchItem> missPunchList = [];
  List<MissPunchItem> _monthMissPunchList = [];
  late RadioSelectionItemModel selectedNormalFilterItem;
  DateTime selectedMonth =
      DateTime(DateTime.now().year, DateTime.now().month, 1);

  DateTime currentMonth =
      DateTime(DateTime.now().year, DateTime.now().month, 1);

  final List<RadioSelectionItemModel> _radioSelectionList = [
    RadioSelectionItemModel(
      AppStrings.lblAll,
      isSelected: true,
    ),
    RadioSelectionItemModel(
      AppStrings.lblMissed,
      id: MissPunchFilterId.needToApply,
    ),
    RadioSelectionItemModel(
      AppStrings.lblApprove,
      id: MissPunchFilterId.approved,
    ),
    RadioSelectionItemModel(
      AppStrings.lblPending,
      id: MissPunchFilterId.pending,
    ),
    RadioSelectionItemModel(
      AppStrings.lblReject,
      id: MissPunchFilterId.rejected,
    ),
    RadioSelectionItemModel(
      AppStrings.lblExpired,
      id: MissPunchFilterId.expired,
    ),
  ];

  late MissPunchBloc _bloc;

  @override
  void initState() {
    super.initState();
    selectedNormalFilterItem = _radioSelectionList[0];
  }

  @override
  Widget build(BuildContext context) => BaseScreen<MissPunchBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;

        callMissPunchAPI();
      },
      builder: (context, bloc, child) => BlocListener<MissPunchBloc, BaseState>(
          listener: (context, state) {
            if (state is CallMissPunchAPISuccessState) {
              missPunchList = state.data;
              getMissPunchList(selectedMonth);
            } else if (state is CallMissPunchAPIFailedState) {
              showCustomFlushBar(context, state.msg);
            }
          },
          child: _page()));

  /// Created by Dev 2301 on 12/9/2021
  /// Modified by Dev 2301 on 12/9/2021
  /// Purpose : main content view for page
  Widget _page() => ListView(
        children: [
          /// month header
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 20, horizontal: AppStyles.pageSideMargin),
            child: CalendarHeader(
              month: selectedMonth,
              selectedMonth: (value) {
                selectedMonth = value;
                print(selectedMonth);
                getMissPunchList(selectedMonth);
              },
            ),
          ),

          ///radio selection
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppStyles.pageSideMargin),
            child: RadioSelectionView(
                list: _radioSelectionList,
                hasDecoration: false,
                hasSpaceBetween: false,
                fontSize: 12,
                fontWeight: AppFonts.medium,
                onItemChanged: (data) => _onRadioChanged(data)),
          ),

          /*///apply section
          ApplyMissedPunchView(
            onApply: _onApply,
          ),
*/

          ///applied request list
          if (_monthMissPunchList.isNotEmpty)
            MissedPunchListView(
              missPunchList: _monthMissPunchList,
              onApply: (item) {
                navigationPush(context, ApplyMissedPunchScreen(item: item));
              },
            )
          else
            const Center(child: Text(AppStrings.msgNoDataFound)),
          const SizedBox(
            height: 25,
          ),
        ],
      );

  void _onRadioChanged(RadioSelectionItemModel e) {
    selectedNormalFilterItem = e;
    setState(() {
      callMissPunchAPI(missPunchStatus: e.id);
    });
  }

  void callMissPunchAPI({int? missPunchStatus}) {
    ApiService().checkInternet().then((value) {
      if (!value) {
        showNoInternetDialog(context, content: AppStrings.msgInternetShouldOn);
      } else {
        _bloc.add(
            CallMissPunchAPI(pageIndex: 1, missedPunchStatus: missPunchStatus));
      }
    });
  }

  void getMissPunchList(DateTime selectedMonth) {
    _monthMissPunchList.clear();
    setState(() {
      _monthMissPunchList = missPunchList
          .where((element) =>
              getDateFromDateTime(element.createdOn!,
                  format: DateFormats.mmYYYY) ==
              getDateFromDateTime(selectedMonth.toString(),
                  format: DateFormats.mmYYYY))
          .toList();
    });
    print(_monthMissPunchList.length);
  }
}
