import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/core/utils/scroll_utils.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/utils/extensions/grid_type_extension.dart';
import 'package:days/features/home/presentation/widgets/controlbar/contoller.dart';
import 'package:days/features/home/presentation/widgets/controlbar/grid_type_control_bar.dart';
import 'package:days/shared/ui/animation/blurhider.dart';
import 'package:days/shared/ui/layout/card_container.dart';
import 'package:days/shared/ui/typography/paragraph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ControlBar extends StatefulWidget {
  const ControlBar({required this.scrollController, super.key});

  final ScrollController scrollController;

  @override
  State<ControlBar> createState() => _ControlBarState();
}

class _ControlBarState extends State<ControlBar> with TickerProviderStateMixin {
  late final BarController controller;

  @override
  void initState() {
    super.initState();

    controller = BarController(
      bar: AnimationController(
        duration: const Duration(milliseconds: 250),
        vsync: this,
      ),
      gridType: AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      )..forward(),
    );

    widget.scrollController.addListener(onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 458,
        ),
        child: ChangeNotifierProvider(
          create: (context) => controller,
          child: BlurHider(
            controller: controller.bar,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const GridTypeControlBar(),
                CardContainer(
                  padding: Dimensions.large.padding.copyWith(
                    top: Dimensions.normal,
                    bottom: Dimensions.normal,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: onTapGridSettings,
                          child: Text(
                            DateTime.now().year.toString(),
                          ),
                        ),
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: scrollToToDay,
                          child: const Paragraph('Tøday'),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: onTapDateTimeSettings,
                          child: BlocBuilder<SettingsBloc, SettingsModelState>(
                            builder: (context, state) {
                              if (state.state is SettingsLoaded) {
                                final entity = state.entity;
                                return RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${entity.gridType.calculation(
                                          entity.birthday,
                                          DateTime.now(),
                                        )}'
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      TextSpan(
                                        text: '  ${state.entity.gridType.name}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapGridSettings() async {
    if (controller.showGridType) {
      controller.gridType.forward();
    } else {
      controller.gridType.reverse();
    }
    controller.showGridType = !controller.showGridType;
  }

  void onTapDateTimeSettings() async {
    final entity = context.read<SettingsBloc>().state.entity;
    Navigator.of(context).push<DateTimeRange?>(
      CupertinoPageRoute(
        builder: (context) {
          return DateRangePickerDialog(
            firstDate: DateTime(1900),
            lastDate: DateTime(3100),
            initialDateRange: DateTimeRange(
              start: entity.birthday,
              end: entity.endDateTime,
            ),
            initialEntryMode: DatePickerEntryMode.calendarOnly,
          );
        },
      ),
    ).then((value) {
      if (value != null && mounted) {
        if (value.start.isAfter(value.end)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Start date cannot be after end date'),
            ),
          );
          return;
        }

        context.read<SettingsBloc>().add(
              SetSettings(
                entity.copyWith(
                  birthday: value.start,
                  endDateTime: value.end,
                ),
              ),
            );
      }
    });
  }

  void onScroll() {
    if (controller.bar.isAnimating) {
      return;
    }

    ScrollUtils.onScroll(
      widget.scrollController,
      onScrollUp: () {
        controller.bar.reverse();
      },
      onScrollDown: () {
        controller.bar.forward();
        if (controller.showGridType) {
          onTapGridSettings();
        }
      },
    );
  }

  void scrollToToDay() {
    final entity = context.read<SettingsBloc>().state.entity;

    if (entity.birthday.isAfter(DateTime.now())) {
      return;
    }

    final size = MediaQuery.of(context).size;
    const blockSize = Size.square(Dimensions.dotContainerSize);
    final length = entity.gridType.calculation(entity.birthday, DateTime.now());
    final itemsPerRow = ((size.width -
            (blockSize.width / 2 + Dimensions.large.padding.horizontal) * 2) ~/
        blockSize.width);
    final rowIndex = length ~/ itemsPerRow;
    final scrollOffset = rowIndex * blockSize.height;

    final safeAreaPaddingTop = MediaQuery.paddingOf(context).top;
    final compensation = (Dimensions.dotContainerSize * 3) -
        (Dimensions.dotSize * 3) +
        safeAreaPaddingTop;

    if ((widget.scrollController.offset - scrollOffset).abs() > 1) {
      widget.scrollController.animateTo(
        (scrollOffset + compensation).toDouble(),
        duration: const Duration(milliseconds: 2500),
        curve: Curves.easeInOutQuart,
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
