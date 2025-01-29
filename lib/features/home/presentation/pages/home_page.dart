import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/core/services/locator_service.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/widgets/app_bar.dart';
import 'package:days/features/home/presentation/widgets/dot_list_body.dart';
import 'package:days/features/home/presentation/widgets/dot.dart';
import 'package:days/shared/ui/widgets/background_blur.dart';
import 'package:days/shared/ui/widgets/background_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<List<Dot>> dots = <List<Dot>>[];

  var left = 0;
  var todayScrollOffset = 0.0;
  var _scrolling = false;

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
                        slivers: const [
                          HomeAppBar(),
                          DotListBody(),
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
                              child: const Text(
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
                                            text: ' left ${state.entity.gridType.name}',
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
