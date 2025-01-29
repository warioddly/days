import 'dart:ui';

import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/widgets/settings_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlBar extends StatefulWidget {
  const ControlBar({required this.scrollController, super.key});

  final ScrollController scrollController;

  @override
  State<ControlBar> createState() => _ControlBarState();
}

class _ControlBarState extends State<ControlBar>
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    widget.scrollController.addListener(onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final value = _controller.value;
          final sigma = value * 18;
          return ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: sigma,
              sigmaY: sigma,
            ),
            child: value < .8
                ? child
                : null,
          );
        },
        child: Container(
          margin: Dimensions.dotContainerSize.padding.copyWith(
              top: Dimensions.small,
              bottom: Dimensions.large
          ),
          decoration: BoxDecoration(
            borderRadius: Dimensions.normal.allBorder,
            color: Colors.black.withAlpha(180),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.5),
                blurRadius: 10,
              ),
            ],
          ),
          padding: Dimensions.normal.padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onTapSettings,
                  child: Text(
                    DateTime.now().year.toString(),
                  ),
                ),
              ),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    // scrollTo(todayScrollOffset);
                  },
                  child: const Text(
                    'Tøday',
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  // onTap: () => scrollTo(0),
                    child:
                  BlocBuilder<SettingsBloc, SettingsModelState>(
                    builder: (context, state) {
                      if (state.state is SettingsLoaded) {
                        return RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'left'.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall,
                              ),
                              TextSpan(
                                text:
                                ' left ${state.entity.gridType.name}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                  color: Colors.white54,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }

  void onTapSettings() async {
    final entity = context.read<SettingsBloc>().state.entity;

    final result = await showModalBottomSheet<SettingsEntity?>(
      isScrollControlled: true,
      context: context,
      clipBehavior: Clip.antiAlias,
      builder: (context) {
        return SettingBottomSheetContent(
          entity: entity,
        );
      },
    );

    if (result != null && mounted) {
      if (result.birthday.isAfter(result.endDateTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Birthday cannot be after end date'),
          ),
        );
        return;
      }

      context.read<SettingsBloc>().add(SetSettings(result));
    }
  }

  void onScroll() {
    if (_controller.isAnimating) {
      return;
    }
    if (widget.scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

}
