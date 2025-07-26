import 'package:days/core/assets/illustration_assets.dart';
import 'package:days/core/services/di_service.dart';
import 'package:days/features/home/presentation/bloc/dots_manager_notifier.dart';
import 'package:days/features/home/presentation/bloc/grid_type_notifier.dart';
import 'package:days/features/home/presentation/pages/widgets/controlbar/controlbar.dart';
import 'package:days/features/home/presentation/pages/widgets/controlbar/days_left_status.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/dot_grid_body.dart';
import 'package:days/features/home/presentation/pages/widgets/footer/footer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Tooltip;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final gridTypeNotifier = GetIt.I.get<GridTypeNotifier>();
  final dotsManagerModel = DotsManagerNotifier();

  @override
  void initState() {
    super.initState();
    gridTypeNotifier.getGridType();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (kIsWasm || kIsWeb) {
      for (final path in IllustrationAssets.illustrations) {
        precacheImage(AssetImage(path), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: gridTypeNotifier),
        ChangeNotifierProvider.value(value: dotsManagerModel),
      ],
      child: const Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StatusBar(),
              Spacer(),
              DotGridBody(),
              Spacer(),
              ControlBar(),
            ],
          ),
        ),
        bottomNavigationBar: Footer(),
      ),
    );
  }

  @override
  void dispose() {
    gridTypeNotifier.dispose();
    dotsManagerModel.dispose();
    super.dispose();
  }
}
