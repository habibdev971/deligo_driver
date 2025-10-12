import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/image_compressor/compress_image.dart';

Future<File?> pickImageWithSourceSelector(BuildContext context) async {
  final ImageSource? source = await showModalBottomSheet<ImageSource>(
    context: context,
    builder: (ctx) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Pick from Gallery'),
            onTap: () => Navigator.pop(ctx, ImageSource.gallery),
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take a Photo'),
            onTap: () => Navigator.pop(ctx, ImageSource.camera),
          ),
        ],
      ),
    ),
  );

  if (source != null) {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      final file = await compressImage(picked);
      return file;
    }
  }

  return null;
}