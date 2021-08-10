import 'package:flutter/material.dart';
import 'package:unsplash_client/models/photo.dart';

class SinglePhotoScreen extends StatelessWidget {
  final Photo photo;

  const SinglePhotoScreen({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        direction: DismissDirection.vertical,
        onDismissed: (_) => Navigator.of(context).pop(),
        key: Key('PhotoScreen'),
        child: InteractiveViewer(
          child: Image.network(
            photo.full,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        )
    );
  }
}
