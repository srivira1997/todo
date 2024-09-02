// ignore_for_file: file_names, prefer_interpolation_to_compose_strings, unused_local_variable, non_constant_identifier_names, avoid_types_as_parameter_names, unnecessary_null_comparison
import 'package:intl/intl.dart';

class Converts {
  static String formatDateTime(DateTime datetime, {String? format}) {
    return DateFormat(format ?? 'dd-MMM-yyyy').format(datetime);
  }
}
