abstract class PhotoEvent {}

class PhotoEventGetPhotos extends PhotoEvent {
  final int page;

  PhotoEventGetPhotos({this.page = 1});
}

class PhotoEventSearch extends PhotoEvent {
  final String query;
  final int page;

  PhotoEventSearch({this.page = 1, required this.query});
}
