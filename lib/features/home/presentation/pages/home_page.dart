import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/core/services/locator_service.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/utils/extensions/grid_type_extension.dart';
import 'package:days/features/home/presentation/widgets/app_bar.dart';
import 'package:days/shared/ui/dot/dot.dart';
import 'package:days/shared/ui/dot/dots_list_builder.dart';
import 'package:days/shared/ui/widgets/background_blur.dart';
import 'package:days/shared/ui/widgets/background_image.dart';
import 'package:days/shared/utils/dot_builder_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<List<Dot>> dots = <List<Dot>>[];

  var left = 0, todayScrollOffset = 0.0, _scrolling = false;

  final settingsBloc = $getIt<SettingsBloc>();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    settingsBloc.add(GetSettings());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: BlocProvider(
          create: (context) => settingsBloc,
          child: Stack(
            children: [

              const BackgroundBlur(),

              SafeArea(
                top: false,
                child: Column(
                  children: [

                    Expanded(
                      child: CustomScrollView(
                        controller: scrollController,
                        slivers: [

                          const HomeAppBar(),

                          BlocConsumer<SettingsBloc, SettingsModelState>(
                            bloc: settingsBloc,
                            listener: (context, state) {

                              final eventState = state.state;

                              if (eventState is SettingsLoaded) {
                                init();
                              }

                            },
                            builder: (context, state) {

                              final eventState = state.state;

                              if (eventState is SettingsLoaded) {
                                return DotsListBuilder(
                                    dots: dots
                                );
                              }

                              if (eventState is SettingsError) {
                                return SliverToBoxAdapter(
                                  child: Text(
                                    eventState.message.toString(),
                                    style: Theme.of(context).textTheme.bodySmall,
                                  )
                                );
                              }

                              return SliverToBoxAdapter(
                                child: const CupertinoActivityIndicator(),
                              );

                            }
                          )

                        ],
                      ),
                    ),

                    Container(
                      margin: Dimensions.dotContainerSize.padding.copyWith(
                        top: Dimensions.small,
                        bottom: Dimensions.empty,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Expanded(
                            child: Text(
                              DateTime.now().year.toString(),
                            ),
                          ),

                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                scrollTo(todayScrollOffset);
                              },
                              child: Text(
                                'Tøday',
                              ),
                            ),
                          ),

                          Expanded(
                            child: GestureDetector(
                              onTap: () => scrollTo(0),
                              child: BlocBuilder<SettingsBloc, SettingsModelState>(
                                builder: (context, state) {

                                  if (state.state is SettingsLoaded) {
                                    return RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: left.toString(),
                                            style: Theme.of(context).textTheme.bodySmall,
                                          ),
                                          TextSpan(
                                            text: '$left ${state.entity.gridType.name.toLowerCase()}',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
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

            ]
          ),
        ),
      ),
    );
  }

  void init() {

    final settings = settingsBloc.state.entity;
    final now = DateTime.now();
    final from = settings.birthday;
    final to = settings.endDateTime;
    final gridType = settings.gridType;
    final dotContainerSize = Dimensions.dotContainerSize;
    final size = MediaQuery.of(context).size;
    final dotsPerRow = ((size.width - (dotContainerSize / 2 + Dimensions.dotSize) * 2) ~/ dotContainerSize);
    final dotsPerColumn = size.height ~/ dotContainerSize;
    final safeAreaCompensation = MediaQuery.of(context).padding.bottom;

    left = gridType.calculation(from, now);

    print('from $from');
    print('to $to');

    dots = DotBuilderUtils.buildDots(
        from: from,
        to: to,
        now: now,
        gridType: gridType,
        dotsPerRow: dotsPerRow,
        beforeOffsetCallback: (int index) {
          todayScrollOffset = (index * dotContainerSize) + (dotsPerColumn - safeAreaCompensation);
        },
    );

    if (mounted) {
      Future.delayed(Duration.zero, () => scrollTo(todayScrollOffset));
    }

  }

  void scrollTo(double offset) {
    if (_scrolling) {
      return;
    }
    _scrolling = true;
    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 2000),
      curve: Curves.easeInOutQuart,
    ).then((_) => _scrolling = false);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

}
