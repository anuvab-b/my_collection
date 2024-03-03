import 'package:flutter/material.dart';
import 'package:my_collection/utils/routes/route_names.dart';
import 'package:my_collection/view/music/music_search_delegate.dart';
import 'package:my_collection/view/music/playlists/playlist_list_view.dart';
import 'package:my_collection/view/widgets/search_widget_container.dart';
import 'package:my_collection/viewmodel/playlist_provider.dart';
import 'package:provider/provider.dart';

class MusicHomeScreen extends StatelessWidget {
  const MusicHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(builder: (context, provider, child) {
      return Container(
          margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
          child: Column(children: [
            const SizedBox(height: 16.0),
            SearchWidgetContainer(
                hintText: "Search for Songs, Artists, etc...",
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: MusicSearchDelegate(buildContext: context),
                  );
                }),
            const SizedBox(height: 16.0),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: () async {
                  Navigator.pushNamed(context, RouteNames.createPlayListForm);
                },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).primaryColorDark),
                child: Text(
                  "Create a Playlist",
                  style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontSize: 18,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(child: PlayListListView(onTap: (_) {
              provider.setSelectedPlayListIndex(_);
              Navigator.pushNamed(context, RouteNames.playListDetails);
            }))
          ]));
    });
  }
}
