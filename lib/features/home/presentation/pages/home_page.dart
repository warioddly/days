import 'package:days/core/constants/app_constants.dart';
import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/services/locator_service.dart';
import 'package:days/core/utils/datetime_utils.dart';
import 'package:days/features/home/presentation/bloc/dots_manager/dots_manager_bloc.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/widgets/controlbar/controlbar.dart';
import 'package:days/features/home/presentation/widgets/controlbar/grid_type_status_bar.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dot_grid_body.dart';
import 'package:days/features/home/presentation/widgets/footer/footer.dart';
import 'package:days/features/home/presentation/widgets/tooltip/orbit_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_widget/home_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final settingsBloc = getIt<SettingsBloc>();
  final dotsManagerBloc = getIt<DotsManagerBloc>();
  final orbitTooltip = OrbitTooltipNotifier();

  @override
  void initState() {
    super.initState();
    settingsBloc.add(GetSettings());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      HomeWidget.setAppGroupId(AppConstants.homeWidgetAppGroupId);
      await HomeWidget.saveWidgetData(
        AppConstants.homeWidgetDaysDataKey,
        DateTimeUtils.getDaysFrom(
          DateTime(DateTime.now().year),
          DateTime.now(),
        ),
      );
      await HomeWidget.updateWidget(
        name: AppConstants.daysHomeWidgetName,
        iOSName: AppConstants.iosHomeWidgetName,
        androidName: AppConstants.androidHomeWidgetName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => settingsBloc),
            BlocProvider(create: (context) => dotsManagerBloc),
            ChangeNotifierProvider(create: (context) => orbitTooltip),
            BlocProvider(create: (context) => settingsBloc),
            BlocProvider(create: (context) => dotsManagerBloc),
            ChangeNotifierProvider(create: (context) => orbitTooltip),
          ],
          child: Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: Dimensions.maxViewWidthSize,
                    ),
                    child: const Column(
                      children: [
                        GridTypeStatusBar(),
                        Spacer(),
                        DotGridBody(),
                        Spacer(),
                        ControlBar(),
                        Footer(),
                      ],
                    ),
                  ),
                ),
              ),
              const OrbitTooltip(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    settingsBloc.close();
    dotsManagerBloc.close();
    orbitTooltip.dispose();
    super.dispose();
  }
}
