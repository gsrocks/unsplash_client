import 'package:unsplash_client/models/photo.dart';

abstract class PhotoState {}

class PhotoStateEmpty extends PhotoState {}

class PhotoStateInProgress extends PhotoState {}

class PhotoStateFailed extends PhotoState {}

class PhotoStateSuccess extends PhotoState {
  final List<Photo> photos;

  PhotoStateSuccess(this.photos);
}
