import 'dart:ui';
import 'package:days/core/extensions/string_extensions.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/widgets/settings_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> with SingleTickerProviderStateMixin {

  late final AnimationController _controller;
  GridType viewType = GridType.days;
  var title = '';

  @override
  void initState() {
    super.initState();
    // viewType = widget.viewType;
    title = viewType.name;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: false,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {

              final value = _controller.value;

              if (value > .5) {
                title = viewType.name;
              }

              return ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: value * 10,
                  sigmaY: value * 5,
                ),
                child: Text(
                    title.capitalize,
                ),
              );
            }
        ),
      ),
      actions: [

        IconButton(
          icon: const Icon(CupertinoIcons.calendar),
          onPressed: _actionModal,
        )

      ],
    );
  }

  void _actionModal() {

    showModalBottomSheet(
        context: context,
        clipBehavior: Clip.antiAlias,
        builder: (context) {
          return BlocProvider(
            create: (context) => this.context.read<SettingsBloc>(),
            child: SettingBottomSheetContent(),
          ) ;
        }
    );

  }

  // void _onTypeChanged(ViewType type) {
  //     _controller.forward(from: 0.0).then((value) => _controller.reverse());
  //     widget.onTypeChanged(viewType = type);
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}
