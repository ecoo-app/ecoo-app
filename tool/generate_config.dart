import 'dart:io';

Future<void> main() async {
  final config = {
    'paperwallet_decryption_key':
        Platform.environment['APP_PAPERWALLET_DECRYPTION_KEY'],
  };

  final filename = 'lib/config.generated.dart';

  var stringBuilder = StringBuffer();
  config.forEach((key, value) {
    if (value != null) {
      stringBuilder.write('''  static const ${key} = '${value}';\n''');
    }
  });

  await File(filename).writeAsString('''class Config {
${stringBuilder.toString()}}\n''');
}
