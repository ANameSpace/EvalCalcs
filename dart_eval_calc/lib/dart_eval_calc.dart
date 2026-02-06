import 'dart:isolate';

final RegExp expressionRegex = RegExp(r'^[0-9+\-*/()~<>!= ]+$');
const String src = '''
import "dart:isolate";
import "dart:math";

void main(List<String> args, SendPort port) {
  port.send((%input%).toString());
}
''';

Future<String> calculate(String input) async  {
  if (!expressionRegex.hasMatch(input)) {
    throw FormatException('Выражение содержит недопустимые символы');
  }

  final uri = Uri.dataFromString(
    src.replaceFirst("%input%", input),
    mimeType: 'application/dart',
  );

  try {
    final port = ReceivePort();
    await Isolate.spawnUri(uri, [], port.sendPort);
    final String response = await port.first;    
    return response;
  } catch (e) {
    throw Exception("Произошла ошибка при выполнении вычислений!");
  }
}