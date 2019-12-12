import 'package:intl/date_symbol_data_local.dart';


class TimeFormat {
  static Future<TimeFormat> load(String locale) async {
    await initializeDateFormatting(locale);

    return TimeFormat();
  }
}