
import 'package:days/features/app/presentation/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({required this.child, super.key});

  final Widget child;

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    // ignore: deprecated_member_use
    var brightness = WidgetsBinding.instance.window.platformBrightness;
    context.read<ThemeBloc>().add(SetTheme(brightness));
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

}
