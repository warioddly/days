import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/core/utils/scroll_utils.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
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
  
  bool showGridType = false;

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
                          onTap: () {
                            // scrollTo(todayScrollOffset);
                          },
                          child: const Paragraph('Tøday'),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: onTapDateTimeSettings,
                          child: BlocBuilder<SettingsBloc, SettingsModelState>(
                            builder: (context, state) {
                              if (state.state is SettingsLoaded) {
                                return RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'left'.toString(),
                                        style:
                                            Theme.of(context).textTheme.bodyMedium,
                                      ),
                                      TextSpan(
                                        text: ' left ${state.entity.gridType.name}',
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
    if (showGridType) {
      controller.gridType.forward();
    } else {
      controller.gridType.reverse();
    }
    showGridType = !showGridType;
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
        if (showGridType) {
          onTapGridSettings();
        }
      },
    );

  }

}
