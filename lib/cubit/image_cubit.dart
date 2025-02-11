import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitial());

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        emit(ImageSuccess(image: imageFile));
      } else {
        emit(ImageFailer(error: "No image selected"));
      }
    } catch (e) {
      emit(ImageFailer(error: e.toString()));
    }
  }
}
