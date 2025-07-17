
extension StringExtensions on String {

  String get capitalize {
    return length > 1 ? '${this[0].toUpperCase()}${substring(1)}' : this;
  }

}
