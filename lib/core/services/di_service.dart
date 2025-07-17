import 'package:days/core/interfaces/locator_module_interface.dart';
import 'package:days/features/app/di.dart';
import 'package:days/features/home/di.dart';
import 'package:days/shared/package/logger/_logger.dart' show Logger;

final class GetIt {

  GetIt._();

  static final GetIt _instance = GetIt._();

  static GetIt get I => _instance;

  final _bucket = <Type, dynamic>{};

  T get<T extends Object>() {
    assert(
      _bucket.containsKey(T),
      'Instance of $T not found. Did you forget to register it?',
    );
    final instance = _bucket[T];

    return switch (instance) {
      final T Function() factory => factory(),
      final T value => value,
      _ => instance,
    };
  }

  Future<T> getAsync<T extends Object>() async {
    assert(
      _bucket.containsKey(T),
      'Instance of $T not found. Did you forget to register it?',
    );

    final instance = _bucket[T];

    if (instance is Future<T> Function()) {
      return instance();
    } else {
      throw Exception('Instance of $T is not async. Use get<$T>() instead.');
    }
  }

  void register<T extends Object>(T instance) {
    _assertContains<T>();
    _bucket[T] = instance;
  }

  void registerFactory<T extends Object>(T Function() factory) {
    _assertContains<T>();
    _bucket[T] = factory;
  }

  void _assertContains<T extends Object>() {
    if (_bucket.containsKey(T)) {
      Logger.w('Instance of $T already registered, replacing it');
    }
  }
}

Future<void> $setupAppModules() async {
  Logger.i('Setting up dependency injection');

  final modules = <LocatorModule>[AppModule(), HomeModule()];

  for (final module in modules) {
    await module.builder(GetIt.I);
  }

  Logger.i('Dependency injection setup complete');
}
