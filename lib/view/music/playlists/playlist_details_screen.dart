import 'package:flutter/material.dart';

class PlayListDetailsScreen extends StatelessWidget {
  const PlayListDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text("My Playlist #",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    fontSize: 24)),
            const SizedBox(height: 16),
            const Text("Username username",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
            const SizedBox(height: 24),
            Container(
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
                      onPressed: () {},
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
        ),
      ),
    );
  }
}
