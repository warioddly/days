import 'package:days/core/assets/illustration_assets.dart';
import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/home/presentation/bloc/dots_manager/dots_manager_bloc.dart';
import 'package:days/features/home/presentation/widgets/dot/default_dot.dart';
import 'package:days/shared/models/vector2.dart';
import 'package:days/shared/ui/animation/utils/curves.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class IllustratedDot extends StatefulWidget {
  final Vector2 position;
  final DateTime? date;
  final Color? color;
  final bool showBoxShadow;
  final bool isActive;

  const IllustratedDot(this.position, {
    super.key,
    this.date,
    this.color,
    this.showBoxShadow = false,
    this.isActive = true,
  });

  const IllustratedDot.before(Vector2 position, {
    Key? key,
    DateTime? date,
    bool showBoxShadow = false,
    bool bloomed = false,
  }) : this(
    position,
    date: date,
    color: Colors.white,
    showBoxShadow: showBoxShadow,
    isActive: bloomed,
    key: key,
  );

  const IllustratedDot.after(Vector2 position, {
    Key? key,
    DateTime? date,
    bool showBoxShadow = true,
    bool isActive = true,
  }) : this(
    position,
    date: date,
    color: Colors.white12,
    showBoxShadow: showBoxShadow,
    isActive: isActive,
    key: key,
  );

  const IllustratedDot.current(Vector2 position, {
    Key? key,
    DateTime? date,
    bool showBoxShadow = true,
    bool pulse = true,
    bool isActive = true,
  }) : this(
    position,
    date: date,
    color: Colors.tealAccent,
    showBoxShadow: showBoxShadow,
    key: key,
    isActive: isActive,
  );

  @override
  State<IllustratedDot> createState() => _IllustratedDotState();
}

class _IllustratedDotState extends State<IllustratedDot>
    with AutomaticKeepAliveClientMixin {

  bool isActive = false;
  Color color = Colors.white;

  final dot = const DefaultDot();
  late final illustration = Image.asset(
    IllustrationAssets.getRandomIllustration(),
    color: color,
  );

  @override
  void initState() {
    super.initState();
    isActive = widget.isActive;
    color = widget.color ?? Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<DotsManagerBloc, DotsManagerModelState>(
      listener: _listener,
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerHover: _animate,
        onPointerDown: _animate,
        child: SizedBox.square(
          dimension: Dimensions.dotContainerSize,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 450),
            reverseDuration: const Duration(milliseconds: 500),
            switchInCurve: SharedCurves.bounceAnimation,
            switchOutCurve: Curves.fastEaseInToSlowEaseOut,
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: child,
            ),
            child: isActive ? illustration : dot,
          ),
        ),
      ),
    );
  }

  void _animate(_) {

    if (widget.date != null) {
      print(widget.date?.toIso8601String() ?? '');
    }

    if (isActive) {
      return;
    }

    isActive = !isActive;
    color = Colors.white;

    setState(() {});
  }

  void _listener(BuildContext context, DotsManagerModelState state) {

    final eventState = state.state;

    if (eventState is DotsManagerUserOutsideClicked) {
        isActive = false;
        setState(() { });
    }

  }

  @override
  bool get wantKeepAlive => isActive;

}
