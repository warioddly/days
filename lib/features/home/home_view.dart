import 'package:days/core/assets/illustration_assets.dart';
import 'package:days/core/base/view_model.dart';
import 'package:days/features/home/dots_view_model.dart';
import 'package:days/features/home/home_view_model.dart';
import 'package:days/features/home/widgets/controlbar/control_bar.dart';
import 'package:days/features/home/widgets/controlbar/status_bar.dart';
import 'package:days/features/home/widgets/dot_grid/dot_grid_body.dart';
import 'package:days/features/home/widgets/footer/footer.dart';
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
      ),
    );
  }

}
