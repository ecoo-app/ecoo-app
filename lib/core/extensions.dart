extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

extension StringExtensions on String {
  bool isNullOrEmpty() {
    return this == null || this.isEmpty;
  }

  bool isNotNullAndDouble() {
    if (this == null) {
      return false;
    }

    return this.isNotEmpty && double.tryParse(this) != null;
  }
}
