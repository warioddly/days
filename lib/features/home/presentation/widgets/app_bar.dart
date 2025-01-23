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
  var title = '';
  var gridType = GridType.months;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    return SliverAppBar(
      floating: false,
      pinned: false,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: BlocListener<SettingsBloc, SettingsModelState>(
          bloc: bloc,
          listenWhen: (previous, current) => true,
          listener: (context, state) {

            if (state.state is SettingsLoaded && gridType != state.entity.gridType) {
                _controller.forward(from: 0.0).then((value) => _controller.reverse());
                gridType = state.entity.gridType;
            }

          },
          child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {

                final value = _controller.value;
                final gridName = gridType.name;

                if (title.isEmpty) {
                  title = gridName;
                }

                if (value > .5) {
                  title = gridName;
                }

                return ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: value * 10,
                    sigmaY: value * 5,
                  ),
                  child: Text(
                    title.capitalize,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
          ),
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

  void _actionModal() async {

    final entity = context.read<SettingsBloc>().state.entity;

    final result = await showModalBottomSheet<SettingsEntity?>(
        isScrollControlled: true,
        context: context,
        clipBehavior: Clip.antiAlias,
        builder: (context) {
          return SettingBottomSheetContent(
            entity: entity,
          );
        }
    );

    if (result != null && mounted) {

      if (result.birthday.isAfter(result.endDateTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Birthday cannot be after end date'),
          ),
        );
        return;
      }

      context.read<SettingsBloc>().add(SetSettings(result));
    }

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}
