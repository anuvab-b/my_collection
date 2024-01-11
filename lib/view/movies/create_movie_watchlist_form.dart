import 'package:flutter/material.dart';
import 'package:my_collection/view/widgets/common_loader.dart';
import 'package:my_collection/viewmodel/movie_watchlist_provider.dart';
import 'package:provider/provider.dart';
class CreateMovieWatchListForm extends StatelessWidget {
  const CreateMovieWatchListForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieWatchListProvider>(builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Give your Watchlist a name",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      fontSize: 20)),
              const SizedBox(height: 40.0),
              TextFormField(
                textAlign: TextAlign.center,
                focusNode: provider.seriesMovieListNameNode,
                onChanged: (_) {},
                controller: provider.seriesMovieListNameTextController,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        fontSize: 20),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColorLight),
                    ),
                    hintText: "My Watchlist"),
              ),
              const SizedBox(height: 40.0),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: TextButton(
                        onPressed: Navigator.of(context).pop,
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(
                                  color: Theme.of(context).primaryColorLight),
                            ),
                            backgroundColor: Colors.transparent,
                            foregroundColor:
                            Theme.of(context).primaryColorLight),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          if (provider.seriesMovieListNameTextController.text.isNotEmpty) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                barrierColor: Colors.transparent,
                                builder: (ctx) {
                                  return const CommonLoader();
                                });
                            await provider.createNewMovieWatchList();
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            backgroundColor: Colors.green,
                            foregroundColor:
                            Theme.of(context).primaryColorDark),
                        child: const Text(
                          "Create",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}