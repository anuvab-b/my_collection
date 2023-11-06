import 'package:flutter/material.dart';
import 'package:my_collection/repository/movies/movie_repository.dart';
import 'package:provider/provider.dart';
class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Movies Section"),
      ),
    );
  }
}
