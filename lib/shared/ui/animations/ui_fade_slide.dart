import 'package:days/shared/ui/animations/ui_curves.dart';
import 'package:flutter/material.dart';

class UIFadeSlide extends StatefulWidget {
  const UIFadeSlide({
    required this.beginOffset,
    this.fadeDuration = Durations.medium1,
    this.slideDuration = Durations.extralong4,
    super.key,
    this.child,
  });

  final Offset beginOffset;
  final Duration fadeDuration;
  final Duration slideDuration;
  final Widget? child;

  @override
  State<UIFadeSlide> createState() => _UIFadeSlideState();
}

class _UIFadeSlideState extends State<UIFadeSlide>
    with TickerProviderStateMixin {
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  late final AnimationController _fadeController;
  late final AnimationController _slideController;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: widget.fadeDuration,
    );

    _slideController = AnimationController(
      vsync: this,
      duration: widget.slideDuration,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.fastOutSlowIn,
    );

    _slideAnimation = Tween<Offset>(begin: widget.beginOffset, end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _slideController,
            curve: UICurves.bounceSwitchAnimation,
          ),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_fadeController, _slideController]),
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }
}
