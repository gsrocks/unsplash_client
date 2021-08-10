import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_client/bloc/photo_event.dart';
import 'package:unsplash_client/bloc/photo_state.dart';
import 'package:unsplash_client/models/photo.dart';
import 'package:unsplash_client/services/photo_service.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoService service;

  PhotoBloc({required this.service}) : super(PhotoStateEmpty());

  @override
  Stream<PhotoState> mapEventToState(PhotoEvent event) async* {
    Future<List<Photo>?>? result;
    if(event is PhotoEventGetPhotos) {
      result = service.getPhotos(event.page);
    } else if(event is PhotoEventSearch) {
      result = service.getPhotosByKeyword(event.query, event.page);
    }
    if(result != null) {
      yield PhotoStateInProgress();
      final data = await result;
      if (data == null){
        if(data!.isNotEmpty) {
          yield PhotoStateFailed();
        } else {
          yield PhotoStateEmpty();
        }
      } else {
        yield PhotoStateSuccess(data);
      }
    } else {
      yield PhotoStateEmpty();
    }
  }
}
