import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/base/base_bloc.dart';
import '../../exports/resources.dart';
import '../../resources/app_colors.dart';

/// Created by Dev 2301 on 10/28/2021
/// Modified by Dev 2301 on 10/28/2021
/// Purpose : this widget will display loader view based on the received state
class LoaderView<T extends BaseBloc> extends StatelessWidget {
  const LoaderView({this.loader, Key? key}) : super(key: key);

  final Widget? loader;

  @override
  Widget build(BuildContext context) => _buildLoader();

  Widget _buildLoader() => BlocBuilder<T, BaseState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return state.isLoading
                ? (loader ?? CustomLoader.normal())
                : Container(
            );
          }
          return Container();
        },
      );
}

// ignore: avoid_classes_with_only_static_members
/// Created by Dev 2301 on 7/29/2021
/// Modified by Dev 2301 on 7/29/2021
/// Purpose : class for custom loading indicators used in the app
class CustomLoader {
  static Widget small() => Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: progressIndicator(),
        ),
      );

  static Widget normal() => AbsorbPointer(
    child: Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: progressIndicator(),
          ),
        ),
  );

  static Widget big() => Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: progressIndicator(),
        ),
      );

  static Widget progressIndicator() => const CircularProgressIndicator(
        color: AppColors.primary,
        strokeWidth: 3,
      );
}
