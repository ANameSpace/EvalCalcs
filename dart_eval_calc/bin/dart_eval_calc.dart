  import 'dart:io';
  import 'package:dart_eval_calc/dart_eval_calc.dart';

  void main() async {
    stdout.write("Введите выражение: ");
    final input = stdin.readLineSync() ?? "";
    calculate(input)
      .then((result) => print("Ответ: $result"))
      .catchError((error) => print("[!] $error"));
  }