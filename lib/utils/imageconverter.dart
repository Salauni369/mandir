import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

Future<String> forceConvertToJpg(String originalPath) async {
  final file = File(originalPath);
  final bytes = await file.readAsBytes();

  final decoded = img.decodeImage(bytes);
  if (decoded == null) {
    throw Exception("Image decode failed");
  }

  final dir = await getTemporaryDirectory();
  final newPath =
      "${dir.path}/upload_${DateTime.now().millisecondsSinceEpoch}.jpg";

  final jpgFile = File(newPath)
    ..writeAsBytesSync(
      img.encodeJpg(decoded, quality: 85),
    );

  return jpgFile.path;
}
