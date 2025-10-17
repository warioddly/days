import 'package:days/core/assets/illustration_assets.dart';
import 'package:days/core/base/view_model.dart';
import 'package:days/features/home/dots_view_model.dart';
import 'package:days/features/home/home_view_model.dart';
import 'package:days/features/home/widgets/controlbar/status_bar.dart';
import 'package:days/features/home/widgets/dot_grid/dot_grid_body.dart';
import 'package:days/features/home/widgets/home_view_footer.dart';
import 'package:days/shared/ui/dimensions/dimensions.dart' show Insets;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Tooltip;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final dotsManagerNotifier = DotsViewModel();
  final viewModel = HomeViewModel();

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
  void dispose() {
    viewModel.dispose();
    dotsManagerNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: viewModel,
      child: ViewModelProvider(
        viewModel: dotsManagerNotifier,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            title: const StatusBar(),
          ),
          body: const SafeArea(
            child: Center(
              child: Padding(
                padding: Insets.xlHorizontal,
                child: DotGridBody(),
              ),
            ),
          ),
          bottomNavigationBar: const HomeViewFooter(),
        ),
      ),
    );
  }
}
