import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/dots_manager/dots_manager_bloc.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/shared/package/animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GridTypeStatusBar extends StatelessWidget {
  const GridTypeStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Dimensions.doubledNormal.padding,
      child: Column(
        children: [
          BlocBuilder<DotsManagerBloc, DotsManagerModelState>(
            builder: (context, state) {
              return RepaintBoundary(
                child: AnimatedFlipCounter(
                  value: state.activeDotsCount,
                  duration: const Duration(seconds: 2),
                  curve: Curves.linearToEaseOut,
                  textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color:Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  )
                ),
              );
            },
          ),
          Dimensions.small.verticalBox,
          BlocBuilder<SettingsBloc, SettingsModelState>(
            builder: (context, state) {

              final gridType = state.entity.gridType;
              var title = '';

              if (gridType == GridType.illustrated) {
                title = 'more days of growth';
              } else {
                title = 'days left in the year';
              }

              return Text(
                title,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              );
            },
          )

        ],
      )
    );
  }
}
