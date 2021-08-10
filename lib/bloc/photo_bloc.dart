import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_client/bloc/photo_event.dart';
import 'package:unsplash_client/bloc/photo_state.dart';
import 'package:unsplash_client/services/photo_service.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoService service;

  PhotoBloc({required this.service}) : super(PhotoStateEmpty());

  @override
  Stream<PhotoState> mapEventToState(PhotoEvent event) async* {
    if (event is PhotoEventGetPhotos) {
      final result = service.getPhotos(event.page);
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
    } else if (event is PhotoEventSearch) {
      final result = await service.getPhotosByKeyword(event.query, event.page);
      if (result == null){
        yield PhotoStateFailed();
      } else {
        yield PhotoStateSuccess(result);
      }
    }
  }
}
