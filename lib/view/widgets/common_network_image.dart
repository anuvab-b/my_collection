import 'package:flutter/material.dart';
import 'package:my_collection/utils/data_utils.dart';

class CommonPlaceholderNetworkImage extends StatelessWidget {
  const CommonPlaceholderNetworkImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(DataUtils.imagePlaceholderUrl, fit: BoxFit.fill);
  }
}
