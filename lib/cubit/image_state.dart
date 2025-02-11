part of 'image_cubit.dart';

@immutable
sealed class ImageState {}

final class ImageInitial extends ImageState {}

final class ImageSuccess extends ImageState {
  final File? image;

  ImageSuccess({required this.image});
}

final class ImageFailer extends ImageState {
  final String error;

  ImageFailer({required this.error});
}
