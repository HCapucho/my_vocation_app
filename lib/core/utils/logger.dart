import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Logger {
  static final DateFormat dateFormat = DateFormat("dd/MM/yyyy - HH:mm:ss");

  static erro(Object erro) {
    _print("Erro: ${erro.toString()}", level: 800);
  }

  static info(Object info) {
    _print("Info: ${info.toString()}", level: 900);
  }

  static _print(String txt, {int level = 0}) {
    if (kDebugMode) {
      var date = DateTime.now();
      // print("(${dateFormat.format(date)}) $txt");
      log("(${dateFormat.format(date)}) $txt", level: level);
    }
  }
}
