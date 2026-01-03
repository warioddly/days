import 'package:days/features/home/dot_manager.dart';
import 'package:days/features/home/home_view_model.dart';
import 'package:days/features/home/widgets/dot_grid/dot_grid_body.dart';
import 'package:days/features/home/widgets/home_view_footer.dart';
import 'package:days/features/home/widgets/status_bar.dart';
import 'package:days/features/home/widgets/tooltip/tooltip_provider.dart';
import 'package:days/shared/package/vm/view_model.dart';
import 'package:days/shared/ui/dimensions/dimensions.dart' show Insets;
import 'package:flutter/material.dart' hide Tooltip;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: HomeViewModel(),
      child: ViewModelProvider(
        viewModel: DotManager(),
        child: TooltipProvider(
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
      ),
    );
  }
}
