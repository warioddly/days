
extension StringExtension on String {
  
  String get capitalize {
    if (length >= 2) {
      return '${this[0].toUpperCase()}${substring(1)}';
    }
    return this;
  }

}

