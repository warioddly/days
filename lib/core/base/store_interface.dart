

abstract class Store {

  void get<T>(String key);

  void set(String key, dynamic value);

  void remove(String key);

  void clear() => throw UnimplementedError();

}