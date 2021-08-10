import 'package:dio/dio.dart';
import 'package:unsplash_client/constants/api_path.dart';
import 'package:unsplash_client/models/photo.dart';

class PhotoService {
  final _dio = Dio();
  late Map<String, dynamic> clientIdParams;

  Future<List<Photo>?> getPhotos([int page = 1]) async {
    Map<String, dynamic> params = {
      'client_id': accessKey,
      'page': page,
    };
    try {
      Response response = await _dio.get(
        '$apiPath/photos',
        queryParameters: params,
      );
      if (response.statusCode == 200) {
        if (response.data != null) {
          List<Photo> photos = [];
          for (var item in response.data!) {
            photos.add(Photo.fromJson(item));
          }
          return photos;
        }
      } else {
        print('Error with status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print(e);
    }
  }
}
