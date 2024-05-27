import 'dart:convert';
import 'dart:io';

import 'package:club_cash/src/core/helpers/helper_methods.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ImageServices{

  static Future galleryImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      return image ;
    } on PlatformException catch (e) {
      kPrint('Failed to pick image: $e');
    }
  }

  static Future cameraImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      return image;
    } on PlatformException catch (e) {
      kPrint('Failed to pick image: $e');
    }
  }

  static Future pickMultiImage() async {
    try {
      var pickedFiles = await ImagePicker().pickMultiImage();
      if (pickedFiles.isEmpty) return;
      return pickedFiles ;
    } on PlatformException catch (e) {
      kPrint('Failed to pick image: $e');
    }
  }

  static String getImagePath(File image){
    return File(image.path).path;
  }

  static String? getFileName(File? file){
    return file == null ? null : basename(file.path);
  }

  static Future getImageFile(XFile image)async{
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(image.path);
    final fileImage = File('${directory.path}/$name');

    return File(image.path).copy(fileImage.path);
  }

  static String convertToBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    return 'data:image/jpeg;base64,$base64Image';
  }

  static String decodeBase64(String encoded) {
    String decoded = utf8.decode(base64Url.decode(encoded));
    return decoded;
  }

  static Future<Uint8List> imageUrlToUnit8List(String imageUrl) async {
    /// converting to Uint8List to pass to printer
    var response = await http.get(
      Uri.parse(
        imageUrl,
      ),
    );

    Uint8List bytesNetwork = response.bodyBytes;
    Uint8List imageBytesFromNetwork = bytesNetwork.buffer.asUint8List(
      bytesNetwork.offsetInBytes,
      bytesNetwork.lengthInBytes,
    );

    return imageBytesFromNetwork;
  }

  static Future<Uint8List> imagePathToUnit8List(String path) async {
    /// converting to Uint8List to pass to printer
    ByteData data = await rootBundle.load(path);
    Uint8List imageBytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return imageBytes;
  }

}