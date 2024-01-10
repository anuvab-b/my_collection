import 'package:flutter/material.dart';
import 'package:my_collection/models/music/playlists/playlist_model.dart';
import 'package:my_collection/view/music/music_search_delegate.dart';
import 'package:my_collection/view/music/song_list_item_view.dart';
import 'package:my_collection/viewmodel/playlist_provider.dart';
import 'package:provider/provider.dart';

class PlayListDetailsScreen extends StatelessWidget {
  const PlayListDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
        child: Consumer<PlayListProvider>(builder: (context, provider, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (provider.selectedPlayListIndex != -1 &&
                  provider.playLists[provider.selectedPlayListIndex].items
                      .isNotEmpty)
              ? Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Text(
                            provider
                                .playLists[provider.selectedPlayListIndex].name,
                            style: const TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                fontSize: 24)),
                        const SizedBox(height: 24),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              PlayListItem playListItem = provider
                                  .playLists[provider.selectedPlayListIndex]
                                  .items[index];
                              return SongListItemView(
                                  name: playListItem.name,
                                  album: playListItem.album,
                                  artists: playListItem.artists);
                            },
                            itemCount: provider
                                .playLists[provider.selectedPlayListIndex]
                                .items
                                .length,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  child: Column(children: [
                    const Text("Let's start building your playlist",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            fontSize: 20)),
                    const SizedBox(height: 32.0),
                    SizedBox(
                        child: TextButton(
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: MusicSearchDelegate(buildContext: context),
                        );
                      },
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(
                                color: Theme.of(context).primaryColorLight),
                          ),
                          backgroundColor: Colors.white,
                          foregroundColor: Theme.of(context).primaryColorDark),
                      child: const Text(
                        "Add to this playlist",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600),
                      ),
                    )),
                  ]),
                ),
        ],
      );
    })));
  }
}
