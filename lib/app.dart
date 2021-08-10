import 'package:flutter/material.dart';
import 'package:unsplash_client/constants/styles.dart';
import 'package:unsplash_client/screens/feed_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash Client',
      debugShowCheckedModeBanner: false,
      theme: themeLight,
      home: FeedScreen(),
    );
  }
}
