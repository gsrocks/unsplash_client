import 'package:flutter/material.dart';
import 'package:unsplash_client/constants/styles.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool isSearchMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearchMode ? searchAppbar(context) : defaultAppbar(context),
    );
  }

  void onSearchPressed() {
    setState(() {
      isSearchMode = true;
    });
  }

  void onSearchSubmitted(String input) {
    if(input.trim().isNotEmpty) {
      //TODO: Implement search
      setState(() {
        isSearchMode = false;
      });
    } else {
      setState(() {
        isSearchMode = false;
      });
    }
  }

  PreferredSizeWidget defaultAppbar(BuildContext context) {
    return AppBar(
      title: Text('Unsplash Client',
          style: Theme.of(context).primaryTextTheme.headline6),
      actions: [
        IconButton(
            onPressed: onSearchPressed,
            icon: Icon(Icons.search, color: primaryColor)),
      ],
    );
  }

  PreferredSizeWidget searchAppbar(BuildContext context) {
    return AppBar(
      title: TextFormField(
        autofocus: true,
        onFieldSubmitted: onSearchSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Search',
        ),
      )
    );
  }
}
