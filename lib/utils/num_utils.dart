import 'package:flutter/widgets.dart';

class NumUtils {
  const NumUtils();

  static double parseDouble(dynamic value,
      [double defaultValue, bool acceptNull = false]) {
    if (value is double) {
      return value;
    } else if (value is num) {
      return value.toDouble();
    } else if (value is String) {
      return double.tryParse(value.replaceAll(' ', '').replaceAll(',', '.'));
    } else if (value is TextEditingValue) {
      return parseDouble(value.text);
    } else if (defaultValue != null) {
      return defaultValue;
    } else if (value == null && acceptNull) {
      return defaultValue ?? null;
    } else {
      throw Exception('Not a double !');
    }
  }

  static int parseInt(dynamic value,
      [int defaultValue, bool acceptNull = false]) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value.replaceAll(' ', ''));
    } else if (value is TextEditingValue) {
      return parseInt(value.text);
    } else if (defaultValue != null) {
      return defaultValue ?? defaultValue;
    } else if (value == null && acceptNull) {
      return defaultValue ?? null;
    } else {
      throw Exception('$value is not an int !');
    }
  }

  static num parseNum(dynamic value,
      [num defaultValue, bool acceptNull = false]) {
    if (value is num) {
      return value;
    } else if (value is String) {
      return num.tryParse(value.replaceAll(' ', ''));
    } else if (defaultValue != null) {
      return defaultValue;
    } else if (value == null && acceptNull) {
      return defaultValue ?? null;
    } else {
      throw Exception('$value is not a num !');
    }
  }
}
