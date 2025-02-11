
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piic_app/add_image.dart';
import 'package:piic_app/cubit/image_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AddImage(),
      ),
    );
  }
}

