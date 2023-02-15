import 'package:characters/characters.dart';

extension StringNullExtension on String? {
  bool isNullOrEmpty() {
    final t = this;
    return t == null || t.isEmpty || t.trim().isEmpty;
  }

  String onlyDigits() {
    final t = this;
    if (t == null) {
      return "";
    }
    String aStr = t.replaceAll(RegExp(r'[^0-9]'), '');
    return aStr;
  }

  bool isCpf() {
    final t = this;
    if (t == null || t.isNullOrEmpty()) return false;

    var temp = t.onlyDigits();
    return temp.length == 11;
  }

  bool isCnpj() {
    final t = this;
    if (t == null || t.isNullOrEmpty()) return false;

    var temp = t.onlyDigits();
    return temp.length == 14;
  }

  String capitalize() {
    final t = this;
    if (t == null || t.isNullOrEmpty()) return "";

    if (t.length > 1) {
      return t[0].toUpperCase() + t.substring(1);
    }
    return t.toUpperCase();
  }

  String capitalizeName() {
    final t = this;
    if (t == null || t.isNullOrEmpty()) return "";
    var result = t.split(" ").map((str) => str.capitalize()).join(" ");
    return result;
  }

  bool isValidEmail() {
    final t = this;
    if (t == null || t.isNullOrEmpty()) return false;
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(t);
  }

  bool isValidPhone() {
    final t = this;
    if (t == null || t.isNullOrEmpty()) return false;
    var semSimbolos = onlyDigits().replaceAll("()- ", "");

    RegExp regex1 = RegExp(r'^[0-9]{10}');
    RegExp regex2 = RegExp(r'^[0-9]{11}');
    return regex1.hasMatch(semSimbolos) || regex2.hasMatch(semSimbolos);
  }

  bool isValidPassword() {
    final t = this;
    if (t == null || t.isNullOrEmpty()) return false;

    RegExp regex = RegExp(r'^[a-zA-Z0-9]');
    return regex.hasMatch(t) && t.length >= 8;
  }

  String toPhoneNumber() {
    final t = this;
    if (t == null) return "";
    var tmp = t.onlyDigits();
    var lenght = tmp.length;
    String mask;
    if (lenght == 11) {
      mask = "(##) #####-####";
    } else if (lenght == 10) {
      mask = "(##) ####-####";
    } else if (lenght == 9) {
      mask = "#####-####";
    } else {
      mask = "####-####";
    }

    var result = "";
    var i = 0;

    for (var m in mask.characters) {
      if (m != '#' && tmp.length > mask.length ||
          m != '#' && tmp.length < mask.length && tmp.length != i) {
        result += m;
        continue;
      }

      try {
        result += tmp[i];
      } catch (exception) {
        break;
      }
      i++;
    }
    return result;
  }

  String unmaskPhoneNumber() {
    final t = this;
    if (t == null || t.isEmpty) return "";
    if (t.isValidPhone()) return t.onlyDigits();
    return t;
  }

  String toMaskedPhoneNumber() {
    final t = this;
    if (t == null || t.isNullOrEmpty()) return "";
    var phone = t.toPhoneNumber();
    phone = phone.replaceAll("(", "");
    phone = phone.replaceAll(")", "");

    var first = phone.split('-')[0];
    var second = phone.split('-')[1];

    var re = RegExp(r'[0-9]');
    first = first.replaceAll(re, 'x');

    return "$first-$second";
  }

  String formatCpfCnpj() {
    final t = this;
    if (t == null || t.isNullOrEmpty()) return "";
    var mask = "###.###.###-##";
    if (t.length > 11) {
      mask = "##.###.###/####-##";
    }
    var resultado = "";
    for (var i = 0, j = 0; i < mask.length && j < t.length; i++) {
      var char = mask[i];
      if (char == '#') {
        resultado = resultado + t[j];
        j++;
      } else {
        resultado = resultado + char;
      }
    }
    return resultado;
  }

  String toMaskedCep() {
    final t = this;
    if (t == null || t.isNullOrEmpty()) return "";
    var limpo = onlyDigits();
    var mask = "#####-###";
    if (limpo.length <= 8) {
      var resultado = "";
      for (var i = 0, j = 0; i < mask.length && j < t.length; i++) {
        var char = mask[i];
        if (char == '#') {
          resultado = resultado + t[j];
          j++;
        } else {
          resultado = resultado + char;
        }
      }
      return resultado;
    }
    return limpo;
  }

  String unmaskCpfCnpj() {
    final t = this;
    if (t == null) return "";
    if (t.onlyDigits().isCpf() || t.onlyDigits().isCnpj()) {
      return t.onlyDigits();
    }
    return t;
  }

  String unmaskCep() {
    final t = this;
    if (t == null) return "";
    return t.onlyDigits();
  }

  String getAsCpfCnpjOrEmailFormat() {
    final t = this;
    if (t == null) return "";
    if (t.onlyDigits().isCpf() || t.onlyDigits().isCnpj()) {
      return t.formatCpfCnpj();
    }
    return t;
  }

  String toDecimal() {
    final t = this;
    if (t == null) return "";
    final valueDouble = double.tryParse(t.replaceAll(',', '.')) ?? 0;
    return valueDouble.toStringAsFixed(2).replaceAll('.', ',');
  }

  String trimStart(String character) {
    final text = this;
    if (text == null) return '';

    if (text.isEmpty) {
      return '';
    }

    int i = 0;
    while (i < text.length && text[i] == character) {
      i++;
    }
    return text.substring(i).trim();
  }

  String trimEnd(String character) {
    final text = this;
    if (text == null) return '';

    if (text.isEmpty) {
      return '';
    }

    int i = text.length - 1;
    while (text[i] == character) {
      if (--i < 0) {
        return '';
      }
    }
    return text.substring(0, i + 1).trim();
  }

  String truncate(int limit) {
    var text = this;
    if (text == null) return '';

    if (text.length > limit && limit > 3) {
      text = '${text.substring(0, limit - 3)}...';
    }
    return text;
  }
}

extension StringExtension on String {
  bool isEmpty() {
    return this.isEmpty || trim().isEmpty;
  }

  String onlyDigits() {
    if (isNullOrEmpty()) {
      return "";
    }
    String aStr = replaceAll(RegExp(r'[^0-9]'), '');
    return aStr;
  }

  bool isCpf() {
    if (isNullOrEmpty()) {
      return false;
    }
    var temp = onlyDigits();
    return temp.length == 11;
  }

  bool isCnpj() {
    if (isNullOrEmpty()) {
      return false;
    }
    var temp = onlyDigits();
    return temp.length == 14;
  }

  String capitalize() {
    if (isNullOrEmpty()) return "";

    if (length > 1) {
      return this[0].toUpperCase() + substring(1);
    }
    return toUpperCase();
  }

  String capitalizeName() {
    if (isNullOrEmpty()) return this;
    var result = split(" ").map((str) => str.capitalize()).join(" ");
    return result;
  }

  bool isValidEmail() {
    if (isNullOrEmpty()) return false;

    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(this);
  }

  bool isValidPhone() {
    if (isNullOrEmpty()) return false;
    var semSimbolos = onlyDigits().replaceAll("()- ", "");

    RegExp regex1 = RegExp(r'^[0-9]{10}');
    RegExp regex2 = RegExp(r'^[0-9]{11}');
    return regex1.hasMatch(semSimbolos) || regex2.hasMatch(semSimbolos);
  }

  bool isValidPassword() {
    if (isNullOrEmpty()) return false;

    RegExp regex = RegExp(r'^[a-zA-Z0-9]');
    return regex.hasMatch(this) && length >= 8;
  }

  String toPhoneNumber() {
    if (isNullOrEmpty()) return "";
    var tmp = onlyDigits();
    var lenght = tmp.length;
    String mask;
    if (lenght == 11) {
      mask = "(##) #####-####";
    } else if (lenght == 10) {
      mask = "(##) ####-####";
    } else if (lenght == 9) {
      mask = "#####-####";
    } else {
      mask = "####-####";
    }

    var result = "";
    var i = 0;

    for (var m in mask.characters) {
      if (m != '#' && tmp.length > mask.length ||
          m != '#' && tmp.length < mask.length && tmp.length != i) {
        result += m;
        continue;
      }

      try {
        result += tmp[i];
      } catch (exception) {
        break;
      }
      i++;
    }
    return result;
  }

  String unmaskPhoneNumber() {
    if (isNullOrEmpty() || length == 0) return "";
    if (isValidPhone()) return onlyDigits();
    return this;
  }

  String toMaskedPhoneNumber() {
    if (isNullOrEmpty() || length == 0) return "";
    var phone = toPhoneNumber();
    phone = phone.replaceAll("(", "");
    phone = phone.replaceAll(")", "");

    var first = phone.split('-')[0];
    var second = phone.split('-')[1];

    var re = RegExp(r'[0-9]');
    first = first.replaceAll(re, 'x');

    return "$first-$second";
  }

  String removeSymbol() {
    if (isNullOrEmpty() || length == 0) return "";

    return replaceAll("R\$", "");
  }

  String formatCpfCnpj() {
    var mask = "###.###.###-##";
    if (length > 11) {
      mask = "##.###.###/####-##";
    }
    var resultado = "";
    for (var i = 0, j = 0; i < mask.length && j < length; i++) {
      var char = mask[i];
      if (char == '#') {
        resultado = resultado + this[j];
        j++;
      } else {
        resultado = resultado + char;
      }
    }
    return resultado;
  }

  String toMaskedCep() {
    var limpo = onlyDigits();
    var mask = "#####-###";
    if (limpo.length <= 8) {
      var resultado = "";
      for (var i = 0, j = 0; i < mask.length && j < length; i++) {
        var char = mask[i];
        if (char == '#') {
          resultado = resultado + this[j];
          j++;
        } else {
          resultado = resultado + char;
        }
      }
      return resultado;
    }
    return limpo;
  }

  String unmaskCpfCnpj() {
    if (isNullOrEmpty()) return "";
    if (onlyDigits().isCpf() || onlyDigits().isCnpj()) {
      return onlyDigits();
    }
    return this;
  }

  String unmaskCep() {
    if (isNullOrEmpty()) return "";
    return onlyDigits();
  }

  String getAsCpfCnpjOrEmailFormat() {
    if (isNullOrEmpty()) return "";
    if (onlyDigits().isCpf() || onlyDigits().isCnpj()) {
      return formatCpfCnpj();
    }
    return this;
  }

  String toDecimal() {
    final t = this;
    final valueDouble = double.tryParse(t.replaceAll(',', '.')) ?? 0;
    return valueDouble.toStringAsFixed(2).replaceAll('.', ',');
  }

  String trimStart(String character) {
    final text = this;
    if (text.isEmpty) {
      return '';
    }

    int i = 0;
    while (i < text.length && text[i] == character) {
      i++;
    }
    return text.substring(i).trim();
  }

  String trimEnd(String character) {
    final text = this;
    if (text.isEmpty) {
      return '';
    }

    int i = text.length - 1;
    while (text[i] == character) {
      if (--i < 0) {
        return '';
      }
    }
    return text.substring(0, i + 1).trim();
  }
}
