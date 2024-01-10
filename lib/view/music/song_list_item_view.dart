import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/models/music/spotify_search_response_model.dart'
    as search;

class SongListItemView extends StatelessWidget {
  final String name;
  final search.AlbumElement? album;
  final List<search.Owner>? artists;

  const SongListItemView(
      {Key? key, required this.name, this.album, this.artists})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
        child: Row(children: [
          SizedBox(
              height: 48,
              width: 48,
              child: (album != null && album!.images.isNotEmpty)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                        imageUrl: "${album?.images.first.url}",
                      ),
                    )
                  : Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/310px-Placeholder_view_vector.svg.png",
                      fit: BoxFit.fill)),
          const SizedBox(width: 8.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).highlightColor)),
                const SizedBox(height: 4.0),
                Row(children: [
                  Text("Song",
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColorLight)),
                  const SizedBox(width: 4.0),
                  const Icon(Icons.circle, size: 4.0),
                  const SizedBox(width: 4.0),
                  if (artists != null && artists!.isNotEmpty)
                    Flexible(
                      child: Text(
                          artists!.map((e) => e.name).toList()?.join(',') ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColorLight)),
                    ),
                ])
              ],
            ),
          ),
          InkWell(child: const Icon(Icons.more_vert), onTap: () {})
        ]));
  }
}
