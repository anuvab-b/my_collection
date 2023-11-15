import 'package:flutter/material.dart';
import 'package:my_collection/view/music/music_search_delegate.dart';

class MusicSearchScreen extends StatelessWidget {
  const MusicSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          forceElevated: true,
          elevation: 4,
          floating: true,
          snap: true,
          title: const Text(
            "Search Example",
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MusicSearchDelegate(),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.filter_list_rounded,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ],
    ));
  }
}
