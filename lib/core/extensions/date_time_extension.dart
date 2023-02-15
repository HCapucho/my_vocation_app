import 'package:intl/intl.dart';
import 'package:my_vocation_app/core/extensions/string_exstension.dart';

extension DateTimeExtension on DateTime? {
  static const String dateFormatDDMMYYYY = "dd/MM/yyyy";
  static const String dateFormatYYYYMMDDHHMM = "yyyyMMddHHmm";
  static const String dateFormatYYYYMMDDHHMMSS = "yyyy-MM-dd-HHmmss";
  static const String dateFormatDDMM = 'MMMMd';
  static const String dateTimeFormatDDMMYYYY = "dd/MM/yyyy HH:mm";
  static const String timeFormatHHMM = "HH:mm";

  String toJson() {
    if (this != null) {
      return this!.toIso8601String();
    }
    return '';
  }

  String format(String pattern) {
    try {
      return DateFormat(pattern).format(this!);
    } catch (e) {
      return "";
    }
  }

  String asDateFormat() {
    try {
      return DateFormat(dateFormatDDMMYYYY).format(this!);
    } catch (e) {
      return "";
    }
  }

  String asDateFormatNoSeparator() {
    try {
      return DateFormat(dateFormatYYYYMMDDHHMM).format(this!);
    } catch (e) {
      return "";
    }
  }

  String asDateTimeFormatHifen() {
    try {
      return DateFormat(dateFormatYYYYMMDDHHMMSS).format(this!);
    } catch (e) {
      return "";
    }
  }

  String asDateExtensionFormat() {
    try {
      return DateFormat(dateFormatDDMM).format(this!);
    } catch (e) {
      return "";
    }
  }

  String asDateTimeFormat() {
    try {
      return DateFormat(dateTimeFormatDDMMYYYY).format(this!);
    } catch (e) {
      return "";
    }
  }

  String asAgendamentoFormat() {
    try {
      var data = DateFormat(dateFormatDDMMYYYY).format(this!);
      var horas = DateFormat(timeFormatHHMM).format(this!);
      return "$data às ${horas}h";
    } catch (e) {
      return "";
    }
  }

  bool isSameDate(DateTime other) {
    return this!.year == other.year &&
        this!.month == other.month &&
        this!.day == other.day;
  }

  static DateTime? fromJson(String? valor) {
    if (valor == null || valor.isEmpty) return null;

    final formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    try {
      return formatter.parse(valor);
    } catch (e) {
      return null;
    }
  }

  String greetingMessage() {
    var hour = this!.hour;
    if (hour < 12) {
      return 'Bom dia';
    }
    if (hour < 17) {
      return 'Boa tarde';
    }
    return 'Boa noite';
  }

  String get diaDaSemana {
    if (this == null) {
      return '';
    }
    return DateFormat("EEEE").format(this!).split("-")[0].capitalize();
  }

  String get monthName {
    if (this == null) {
      return '';
    }
    return DateFormat("MMMM").format(this!);
  }
}
