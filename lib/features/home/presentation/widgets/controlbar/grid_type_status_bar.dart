import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GridTypeStatusBar extends StatefulWidget {
  const GridTypeStatusBar({super.key});

  @override
  State<GridTypeStatusBar> createState() => _GridTypeStatusBarState();
}

class _GridTypeStatusBarState extends State<GridTypeStatusBar>
    with TickerProviderStateMixin {

  var title = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    return SizedBox();
    // return SafeArea(
    //   child: GestureDetector(
    //     onTap: () {
    //       bloc.add(
    //         SetSettings(bloc.state.entity.copyWith(gridType: gridType)),
    //       );
    //     },
    //     child: CardContainer(
    //       margin: Dimensions.large.padding.copyWith(bottom: Dimensions.small),
    //       child: BlocListener<SettingsBloc, SettingsModelState>(
    //         bloc: bloc,
    //         listenWhen: (previous, current) => true,
    //         listener: (context, state) {
    //           if (state.state is SettingsLoaded &&
    //               gridType != state.entity.gridType) {
    //             _appGridTypeChangeController
    //                 .forward(from: 0.0)
    //                 .then((value) => _appGridTypeChangeController.reverse());
    //             gridType = state.entity.gridType;
    //           }
    //         },
    //         child: AnimatedBuilder(
    //           animation: _appGridTypeChangeController,
    //           builder: (context, child) {
    //             final value = _appGridTypeChangeController.value;
    //             final gridName = gridType.name;
    //
    //             if (title.isEmpty) {
    //               title = gridName;
    //             }
    //
    //             if (value > .5) {
    //               title = gridName;
    //             }
    //
    //             return ImageFiltered(
    //               imageFilter: ImageFilter.blur(
    //                 sigmaX: value * 10,
    //                 sigmaY: value * 5,
    //               ),
    //               child: Paragraph(
    //                 title.capitalize,
    //               ),
    //             );
    //           },
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

}
