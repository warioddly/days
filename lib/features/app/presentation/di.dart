import 'package:days/core/interfaces/locator_module_interface.dart';
import 'package:days/core/services/locator_service.dart';
import 'package:days/features/app/presentation/bloc/theme_bloc.dart';

class AppModule extends LocatorModule {
  @override
  void builder() {

    getIt.registerFactory(
      () => ThemeBloc(),
    );
  }
}
