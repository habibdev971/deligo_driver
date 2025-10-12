import 'dart:io';
import 'package:dio/dio.dart';

Future<FormData> buildMultipartForm(Map<String, dynamic> data) async {
  final formData = FormData();

  for (final entry in data.entries) {
    final key = entry.key;
    final value = entry.value;

    if (value is File) {
      final fileName = value.path.split('/').last;
      formData.files.add(MapEntry(
        key,
        await MultipartFile.fromFile(
          value.path,
          filename: fileName,
        ),
      ));
    } else {
      // non-file data থাকলে সেটাও অ্যাড করা যাবে
      formData.fields.add(MapEntry(key, value.toString()));
    }
  }

  return formData;
}
