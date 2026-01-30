import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;


Future <MultipartFile> UploadImageToApi(XFile image) async {

  return MultipartFile.fromFile(
    image.path,
    filename: path.basename(image.path.split('.').last.toLowerCase()),
    contentType: MediaType('image', 'jpg')
  );
}
