import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/home/presentation/bloc/dots_manager/dots_manager_bloc.dart';
import 'package:days/shared/package/animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GridTypeStatusBar extends StatefulWidget {
  const GridTypeStatusBar({super.key});

  @override
  State<GridTypeStatusBar> createState() => _GridTypeStatusBarState();
}

class _GridTypeStatusBarState extends State<GridTypeStatusBar>
    with TickerProviderStateMixin {

  var title = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: Dimensions.doubledNormal.padding,
        child: Column(
          children: [
            BlocBuilder<DotsManagerBloc, DotsManagerModelState>(
              builder: (context, state) {
                return AnimatedFlipCounter(
                  value: state.activeDotsCount,
                  duration: const Duration(seconds: 2),
                  curve: Curves.linearToEaseOut,
                  textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                  )
                );
              },
            ),
            Dimensions.small.verticalBox,
            Text(
              'more days of growth',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white24,
              )
            ),
          ],
        )
      ),
    );
  }

}
