import 'package:flutter/material.dart';

class CommonNetworkImage extends StatelessWidget {
  const CommonNetworkImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/310px-Placeholder_view_vector.svg.png",
        fit: BoxFit.fill);
  }
}
