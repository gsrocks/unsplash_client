import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_client/constants/styles.dart';
import 'package:unsplash_client/screens/feed_screen.dart';
import 'package:unsplash_client/services/photo_service.dart';

import 'bloc/photo_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash Client',
      debugShowCheckedModeBanner: false,
      theme: themeLight,
      home: BlocProvider(
        create: (context) => PhotoBloc(service: PhotoService()),
        child: FeedScreen(),
      ),
    );
  }
}
