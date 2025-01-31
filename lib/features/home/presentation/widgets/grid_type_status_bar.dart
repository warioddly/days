import 'dart:ui' hide Paragraph;

import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/core/extensions/string_extensions.dart';
import 'package:days/core/utils/scroll_utils.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/shared/ui/animation/blurhider.dart';
import 'package:days/shared/ui/layout/card_container.dart';
import 'package:days/shared/ui/typography/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GridTypeStatusBar extends StatefulWidget {
  const GridTypeStatusBar({required this.scrollController, super.key});

  final ScrollController scrollController;

  @override
  State<GridTypeStatusBar> createState() => _GridTypeStatusBarState();
}

class _GridTypeStatusBarState extends State<GridTypeStatusBar>
    with TickerProviderStateMixin {
  late final AnimationController _appGridTypeChangeController;
  late final AnimationController _appbarVisibleController;
  var title = '';
  var gridType = GridType.months;

  @override
  void initState() {
    super.initState();
    _appGridTypeChangeController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _appbarVisibleController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    widget.scrollController.addListener(onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    return Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          widget.scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 2500),
            curve: Curves.easeInOutQuart,
          );
        },
        child: BlurHider(
          controller: _appbarVisibleController,
          child: CardContainer(
            margin: Dimensions.large.padding.copyWith(bottom: Dimensions.small),
            child: BlocListener<SettingsBloc, SettingsModelState>(
              bloc: bloc,
              listenWhen: (previous, current) => true,
              listener: (context, state) {
                if (state.state is SettingsLoaded &&
                    gridType != state.entity.gridType) {
                  _appGridTypeChangeController
                      .forward(from: 0.0)
                      .then((value) => _appGridTypeChangeController.reverse());
                  gridType = state.entity.gridType;
                }
              },
              child: AnimatedBuilder(
                animation: _appGridTypeChangeController,
                builder: (context, child) {
                  final value = _appGridTypeChangeController.value;
                  final gridName = gridType.name;

                  if (title.isEmpty) {
                    title = gridName;
                  }

                  if (value > .5) {
                    title = gridName;
                  }

                  return ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: value * 10,
                      sigmaY: value * 5,
                    ),
                    child: Paragraph(
                      title.capitalize,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onScroll() {
    if (_appbarVisibleController.isAnimating) {
      return;
    }
    ScrollUtils.onScroll(
      widget.scrollController,
      onScrollUp: () {
        _appbarVisibleController.reverse();
      },
      onScrollDown: () {
        _appbarVisibleController.forward();
      },
    );
  }

  @override
  void dispose() {
    _appGridTypeChangeController.dispose();
    super.dispose();
  }
}
