import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piic_app/cubit/image_cubit.dart';

class AddImage extends StatelessWidget {
  const AddImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ImageCubit, ImageState>(
      builder: (context, state) {
        File? selectedImage;
        if (state is ImageSuccess) {
          selectedImage = state.image;
        }

        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                  image: selectedImage != null
                      ? DecorationImage(
                          image: FileImage(selectedImage),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: NetworkImage(
                              'https://tse4.mm.bing.net/th?id=OIP.I8HpebN8UlS2rUhTP11XlQHaEK&pid=Api&P=0&h=220'),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      var cubit = context.read<ImageCubit>();
                      chooseSourceImageDialog(
                        context: context,
                        cameraOnTap: () {
                          cubit.pickImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                        galleryOnTap: () {
                          cubit.pickImage(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                      );
                    },
                    icon: const Icon(Icons.camera_alt),
                    color: Colors.blue,
                    iconSize: 20,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}

void chooseSourceImageDialog({
  required BuildContext context,
  required Function() cameraOnTap,
  required Function() galleryOnTap,
}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text(
              'Choose Source',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: cameraOnTap,
                  child: const Text(
                    'Camera',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: galleryOnTap,
                  child: const Text(
                    'Gallery',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ));
}
