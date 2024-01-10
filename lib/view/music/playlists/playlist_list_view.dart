import 'package:flutter/material.dart';
import 'package:my_collection/models/music/playlists/playlist_model.dart';
import 'package:my_collection/viewmodel/playlist_provider.dart';
import 'package:provider/provider.dart';

class PlayListListView extends StatelessWidget {
  final Function(int) onTap;

  const PlayListListView({required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(builder: (context, provider, child) {
      return ListView.builder(
          itemBuilder: (ctx, index) {
            PlayListModel playListModel = provider.playLists[index];
            return InkWell(
              onTap: () => onTap(index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Theme.of(context).primaryColorLight,
                      width: 64,
                      height: 64,
                      child: const Icon(Icons.music_note_outlined),
                    ),
                    const SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(playListModel.name,
                            style: const TextStyle(
                              fontFamily: "JioType",
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            Text("Playlist",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "JioType",
                                    color:
                                        Theme.of(context).primaryColorLight)),
                            const SizedBox(width: 4.0),
                            Icon(Icons.circle,
                                size: 4.0,
                                color: Theme.of(context).primaryColorLight),
                            const SizedBox(width: 4.0),
                            Text("${playListModel.items.length} songs",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "JioType",
                                    color:
                                        Theme.of(context).primaryColorLight)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: provider.playLists.length);
    });
  }
}
