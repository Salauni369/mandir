import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

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






class ImageConverter {
  ImageConverter._(); // prevents instantiation

  static String optimizeCloudinaryUrl(String url) {
    // Not a Cloudinary URL
    if (!url.contains("/upload/")) return url;

    /// ✅ ORIGINAL: Only format convert (avif/webp → png)
    return url.replaceFirst(
      "/upload/",
      "/upload/f_png/",
    );
    return url;
  }
}
