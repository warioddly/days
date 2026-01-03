import 'package:flutter/cupertino.dart';

/// Base class for ViewModels in the application.
abstract class ViewModel extends ChangeNotifier {
  static T of<T extends ViewModel>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_ViewModel<T>>()!.viewModel;
  }
}

/// InheritedNotifier to provide ViewModel to the widget tree.
class _ViewModel<T extends ViewModel> extends InheritedNotifier {
  final T viewModel;

  const _ViewModel({required this.viewModel, required super.child, super.key})
    : super(notifier: viewModel);
}

/// Widget to provide a ViewModel to its descendants.
class ViewModelProvider<T extends ViewModel> extends StatelessWidget {
  const ViewModelProvider({required this.viewModel, required this.child, super.key});

  final T viewModel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _ViewModel<T>(viewModel: viewModel, child: child);
  }
}
