import 'dart:developer';

final class Locator {
  Locator._();

  static final Locator _instance = Locator._();

  static Locator get I => _instance;

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
      _log('Instance of $T already registered, replacing it');
    }
  }

  void _log(String message) => log(message, name: 'Locator');
}
