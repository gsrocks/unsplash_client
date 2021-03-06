import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_client/bloc/photo_bloc.dart';
import 'package:unsplash_client/bloc/photo_event.dart';
import 'package:unsplash_client/bloc/photo_state.dart';
import 'package:unsplash_client/constants/styles.dart';
import 'package:unsplash_client/screens/single_photo_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool isSearchMode = false;
  final searchTextController = TextEditingController();

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearchMode ? searchAppbar(context) : defaultAppbar(context),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: BlocBuilder<PhotoBloc, PhotoState>(
          builder: (context, state) {
            if (state is PhotoStateEmpty) {
              loadPhotos();
              return Center(child: CircularProgressIndicator());
            } else if (state is PhotoStateInProgress) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PhotoStateFailed) {
              return Center(
                child: Text('An error occurred'),
              );
            } else if (state is PhotoStateSuccess) {
              return ListView.builder(
                  itemCount: state.photos.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        showGeneralDialog(
                          barrierDismissible: false,
                          barrierColor: Colors.black.withOpacity(0.8),
                          transitionDuration: Duration(milliseconds: 200),
                          context: context,
                          pageBuilder: (context, anim1, anim2) {
                            return SinglePhotoScreen(photo: state.photos[i]);
                          },
                          transitionBuilder: (context, anim1, anim2, child) {
                            return SlideTransition(
                              position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                                  .animate(anim1),
                              child: child,
                            );
                          },
                        );
                      },
                      child: Image.network(
                        state.photos[i].small,
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text('An error occurred'),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> onRefresh() async {
    loadPhotos();
  }

  void loadPhotos() {
    final rand = Random();
    BlocProvider.of<PhotoBloc>(context).add(PhotoEventGetPhotos(
      page: rand.nextInt(100),
    ));
  }

  void onSearchSubmitted(String input) {
    if (input.trim().isNotEmpty) {
      BlocProvider.of<PhotoBloc>(context).add(PhotoEventSearch(
          query: input.trim(),
      ));
    }
    setState(() => isSearchMode = false);
  }

  PreferredSizeWidget defaultAppbar(BuildContext context) {
    return AppBar(
      title: Text('Unsplash Client',
          style: Theme.of(context).primaryTextTheme.headline6),
      actions: [
        IconButton(
            onPressed: () => setState(() => isSearchMode = true),
            icon: Icon(Icons.search, color: primaryColor)),
      ],
    );
  }

  PreferredSizeWidget searchAppbar(BuildContext context) {
    return AppBar(
      title: TextFormField(
        autofocus: true,
        controller: searchTextController,
        onFieldSubmitted: onSearchSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
        ),
      )
    );
  }
}
